// CBNetworking.m
// Copyright (c) 2016 陈超邦.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "CBNetworking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <CommonCrypto/CommonDigest.h>

#define CB_REQUEST_TIMEOUT 20.f

#define CB_ERROR_IMFORMATION @"Network error，please check the network connection!"

#define CB_ERROR [NSError errorWithDomain:@"com.CBangChen.CBNetworking.ErrorDomain" code:-999 userInfo:@{ NSLocalizedDescriptionKey:CB_ERROR_IMFORMATION}]

#define CB_DIRECTORYPATH [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"] stringByAppendingString:@"/CBNetWorking/"]

#define CB_MAX_CACHE_SIZE (10 * 1024 * 1024)

#define CB_URLCACHE_EXPIRATIONINTERVAL 7 * 24 * 60 * 60

@interface CBURLCache : NSURLCache

@end

static NSString *CBURLCacheExpirationKey     = @"CBURLCacheExpiration";

@interface CBURLCache()

@end

@implementation CBURLCache

+ (instancetype)standardURLCache {
    static CBURLCache *_standardURLCache = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _standardURLCache = [[CBURLCache alloc]
                             initWithMemoryCapacity:CB_MAX_CACHE_SIZE
                             diskCapacity:5 * CB_MAX_CACHE_SIZE
                             diskPath:nil];
    });
    return _standardURLCache;
}

- (id)cachedResponseForRequest:(NSURLRequest *)request {
    NSCachedURLResponse *cachedResponse = [super cachedResponseForRequest:request];
    
    if (cachedResponse) {
        NSDate *cacheDate = cachedResponse.userInfo[CBURLCacheExpirationKey];
        
        NSDate *cacheExpirationDate = [cacheDate dateByAddingTimeInterval:CB_URLCACHE_EXPIRATIONINTERVAL];
        
        if ([cacheExpirationDate compare:[NSDate date]] == NSOrderedAscending) {
            [self removeCachedResponseForRequest:request];
            return nil;
        }
    }
    
    id responseObj = [NSJSONSerialization JSONObjectWithData:cachedResponse.data options:NSJSONReadingAllowFragments error:nil];
    
    return responseObj;
}

- (void)storeCachedResponse:(id)response
               responseObjc:(id)responseObjc
                 forRequest:(NSURLRequest *)request {
    NSData *data = [NSJSONSerialization dataWithJSONObject:responseObjc options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    
    userInfo[CBURLCacheExpirationKey] = [NSDate date];
    
    NSCachedURLResponse *modifiedCachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data userInfo:userInfo storagePolicy:0];
    
    [super storeCachedResponse:modifiedCachedResponse forRequest:request];
}

@end

static NSMutableArray      *requestTasks;

static NSMutableDictionary *headers;

static CBNetworkStatus     networkStatus;

static NSTimeInterval      requestTimeout = CB_REQUEST_TIMEOUT;

@implementation CBNetworking

+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasks == nil) {
            requestTasks = [[NSMutableArray alloc] init];
        }
    });
    return requestTasks;
}

+ (void)configHttpHeaders:(NSDictionary *)httpHeaders {
    headers = httpHeaders.mutableCopy;
}

+ (void)setupTimeout:(NSTimeInterval)timeout {
    requestTimeout = timeout;
}

+ (void)cancelAllRequest {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(CBURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[CBURLSessionTask class]]) {
                [task cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    };
}

+ (void)cancelRequestWithURL:(NSString *)url {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(CBURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[CBURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

+ (AFHTTPSessionManager *)manager {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    [serializer setRemovesKeysWithNullValues:YES];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    manager.requestSerializer.timeoutInterval = requestTimeout;
    
    [self detectNetworkStaus];
    
    if ([self totalCacheSize] > CB_MAX_CACHE_SIZE) [self clearCaches];
    
    return manager;
}

+ (void)updateRequestSerializerType:(CBSerializerType)requestType responseSerializer:(CBSerializerType)responseType {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if (requestType) {
        switch (requestType) {
            case CBHTTPSerializer: {
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                break;
            }
            case CBJSONSerializer: {
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                break;
            }
            default:
                break;
        }
    }
    if (responseType) {
        switch (responseType) {
            case CBHTTPSerializer: {
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                break;
            }
            case CBJSONSerializer: {
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                break;
            }
            default:
                break;
        }
    }
}

+ (CBURLSessionTask *)requestWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                            useCache:(BOOL)useCache
                         httpMedthod:(CBRequestType)httpMethod
                       progressBlock:(CBNetWorkingProgress)progressBlock
                        successBlock:(CBResponseSuccessBlock)successBlock
                           failBlock:(CBResponseFailBlock)failBlock {
    AFHTTPSessionManager *manager = [self manager];
    CBURLSessionTask *session;
    
    if (httpMethod == CBPOSTRequest) {
        
        id response = [CBNetworking getCacheResponseWithURL:url
                                                     params:params];

        successBlock && response && useCache ? successBlock(response) : nil;
        
        if (networkStatus == CBNetworkStatusNotReachable ||  networkStatus == CBNetworkStatusUnknown) {
            failBlock ? failBlock(CB_ERROR) : nil;

            return nil;
        }
        session = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock ? successBlock(responseObject) : nil;
            
            if (useCache) {
                [self cacheResponseObject:responseObject
                                  request:task.currentRequest
                                   params:params];
            }
            
            [[self allTasks] removeObject:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failBlock ? failBlock(error) : nil;
            
            [[self allTasks] removeObject:task];
        }];
        
    }else if(httpMethod == CBGETRequest){
        
        CBURLCache *urlCache = [CBURLCache standardURLCache];
        
        [NSURLCache setSharedURLCache:urlCache];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSCachedURLResponse *cacheResponse =  [[CBURLCache standardURLCache] cachedResponseForRequest:request];
        
        if (cacheResponse) {
            successBlock ? successBlock(cacheResponse) : nil;
        }
        
        if (networkStatus == CBNetworkStatusNotReachable ||  networkStatus == CBNetworkStatusUnknown) {
            failBlock ? failBlock(CB_ERROR) : nil;

            return nil;
        }
        
        session = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                [urlCache storeCachedResponse:task.response
                                 responseObjc:responseObject
                                   forRequest:request];
            }
            
            successBlock ? successBlock(responseObject) : nil;

            [[self allTasks] removeObject:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failBlock ? failBlock(error) : nil;
            
            [[self allTasks] removeObject:task];
        }];
    }
    if (session) {
        [requestTasks addObject:session];
    }
    return  session;
}

+ (CBURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                                 name:(NSString *)name
                                 type:(NSString *)type
                               params:(NSDictionary *)params
                        progressBlock:(CBNetWorkingProgress)progressBlock
                         successBlock:(CBResponseSuccessBlock)successBlock
                            failBlock:(CBResponseFailBlock)failBlock {
    AFHTTPSessionManager *manager = [self manager];
    
    CBURLSessionTask *session = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.4);
        
        NSString *imageFileName;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        imageFileName = [NSString stringWithFormat:@"%@.png", str];
        
        NSString *blockImageType = type;
        
        if (type.length == 0) blockImageType = @"image/jpeg";
        
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:blockImageType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : nil;
        
        [[self allTasks] removeObject:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock ? failBlock(error) : nil;
        
        [[self allTasks] removeObject:task];
    }];
    
    [session resume];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (CBURLSessionTask *)uploadFileWithUrl:(NSString *)url
                          uploadingFile:(NSString *)uploadingFile
                          progressBlock:(CBNetWorkingProgress)progressBlock
                           successBlock:(CBResponseSuccessBlock)successBlock
                              failBlock:(CBResponseFailBlock)failBlock {
    AFHTTPSessionManager *manager = [self manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    CBURLSessionTask *session = nil;
    
    [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [[self allTasks] removeObject:session];
        
        successBlock ? successBlock(responseObject) : nil;

        failBlock && error ? failBlock(error) : nil;
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (CBURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                        progressBlock:(CBNetWorkingProgress)progressBlock
                         successBlock:(CBResponseSuccessBlock)successBlock
                            failBlock:(CBResponseFailBlock)failBlock {
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self manager];
    
    CBURLSessionTask *session = nil;
    
    session = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL URLWithString:saveToPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self allTasks] removeObject:session];
        
        successBlock ? successBlock(filePath.absoluteString) : nil;
        
        failBlock && error ? failBlock(error) : nil;
    }];
    
    [session resume];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (void)detectNetworkStaus {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable){
            networkStatus = CBNetworkStatusNotReachable;
        }else if (status == AFNetworkReachabilityStatusUnknown){
            networkStatus = CBNetworkStatusUnknown;
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi){
            networkStatus = CBNetworkStatusNormal;
        }
    }];
}

+ (void)cacheResponseObject:(id)responseObject
                    request:(NSURLRequest *)request
                     params:(NSDictionary *)params {
    if (request && responseObject && ![responseObject isKindOfClass:[NSNull class]]) {
        NSString *directoryPath = CB_DIRECTORYPATH;
        
        NSError *error = nil;
        if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
        }
        
        NSString *originString = [NSString stringWithFormat:@"%@+%@",request.URL.absoluteString,params];
        
        NSString *path = [directoryPath stringByAppendingPathComponent:[self md5:originString]];
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSData *data = nil;
        if ([dict isKindOfClass:[NSData class]]) {
            data = responseObject;
        } else {
            data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
        }
        if (data && error == nil) {
            [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
        }
    }
}

+ (NSString *)md5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

+ (id)getCacheResponseWithURL:(NSString *)url
                       params:(NSDictionary *)params {
    id cacheData = nil;
    
    if (url) {
        NSString *directoryPath = CB_DIRECTORYPATH;
        
        NSString *originString = [NSString stringWithFormat:@"%@+%@",url,params];

        NSString *path = [directoryPath stringByAppendingPathComponent:[self md5:originString]];
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
        if (data) {
            cacheData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
    }
    return cacheData;
}

+ (unsigned long long)totalCacheSize {
    NSString *directoryPath = CB_DIRECTORYPATH;
    
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    return total;
}

+ (void)clearCaches {
    NSString *directoryPath = CB_DIRECTORYPATH;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
    }
}

@end
