// CBNetworking.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CBNetworking : NSObject

/**
 *  Network Status.
 */
typedef NS_ENUM(NSInteger, CBNetworkStatus) {
    /**
     *  Unknown.
     */
    CBNetworkStatusUnknown             = 1 << 0,
    /**
     *  UnConnected.
     */
    CBNetworkStatusNotReachable        = 1 << 2,
    /**
     *  Normal.
     */
    CBNetworkStatusNormal              = 1 << 3
};

/**
 *  Request Type.
 */
typedef NS_ENUM(NSInteger, CBRequestType) {
    /**
     *  POST.
     */
    CBPOSTRequest = 1 << 0,
    /**
     *  GET.
     */
    CBGETRequest  = 1 << 1
};

/**
 *  Serializer Type.
 */
typedef NS_ENUM(NSInteger, CBSerializerType) {
    /**
     *  HTTP.
     */
    CBHTTPSerializer = 1 << 0,
    /**
     *  JSON.
     */
    CBJSONSerializer = 1 << 1
};

/**
 *  Request Task.
 */
typedef NSURLSessionTask CBURLSessionTask;

/**
 *  Success Block.
 *
 *  @param response success response.
 */
typedef void(^CBResponseSuccessBlock)(id response);

/**
 *  Fail Block.
 *
 *  @param error error imformation.
 */
typedef void(^CBResponseFailBlock)(NSError *error);

/**
 *  Progress.
 *
 *  @param bytesWritten              The size of written file.
 *  @param totalBytes                Th size of complete file.
 */
typedef void(^CBNetWorkingProgress)(int64_t bytesRead,
                                    int64_t totalBytes);

/**
 *  Request Header configer.
 *
 *  @param httpHeaders httpHeaders.
 */
+ (void)configHttpHeaders:(NSDictionary *)httpHeaders;

/**
 *  Cancel all request method.
 */
+ (void)cancelAllRequest;

/**
 *  Cancel request with url.
 *
 *  @param url request url.
 */
+ (void)cancelRequestWithURL:(NSString *)url;

/**
 *	Get the size of cache.
 *
 *	@return the size of cache.
 */
+ (unsigned long long)totalCacheSize;

/**
 *	Clean the cache.
 */
+ (void)clearCaches;

/**
 *	Timeout setter method.
 *
 *  @param timeout time to stop requesting.
 */
+ (void)setupTimeout:(NSTimeInterval)timeout;

/**
 *  Change the type of serializer.(0 HTTP，1 JSON)
 *
 *  @param requestType  requestType.
 *  @param responseType responseType.
 */
+ (void)updateRequestSerializerType:(CBSerializerType)requestType
                 responseSerializer:(CBSerializerType)responseType;

/**
 *  Request method.
 *
 *  @param url              url.
 *  @param params           param.
 *  @param httpMethod       httpMethod.
 *  @param useCache         Yes: use the POST cache.
 *  @param progressBlock    progress Block.
 *  @param successBlock     success Block.
 *  @param failBlock        fail Block.
 *
 *  @return CBURLSessionTask instance.
 */
+ (CBURLSessionTask *)requestWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                            useCache:(BOOL)useCache
                         httpMedthod:(CBRequestType)httpMethod
                       progressBlock:(CBNetWorkingProgress)progressBlock
                        successBlock:(CBResponseSuccessBlock)successBlock
                           failBlock:(CBResponseFailBlock)failBlock;

/**
 *  Post one single picture.
 *
 *	@param image            image.
 *  @param url              url.
 *	@param name             the name of the picture.
 *	@param type             image/jpeg
 *  @param params           param.
 *  @param progressBlock    progress Block.
 *  @param successBlock     success Block.
 *  @param failBlock        fail Block.
 *
 *  @return CBURLSessionTask instance.
 */
+ (CBURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                                 name:(NSString *)name
                                 type:(NSString *)type
                               params:(NSDictionary *)params
                        progressBlock:(CBNetWorkingProgress)progressBlock
                         successBlock:(CBResponseSuccessBlock)successBlock
                            failBlock:(CBResponseFailBlock)failBlock;

/**
 *  Post the file.
 *
 *  @param url              url.
 *  @param uploadingFile    path of the file which you wanna post.
 *  @param progressBlock    progress block.
 *	@param successBlock     success block.
 *	@param failBlock		fail block.
 *
 *  @return CBURLSessionTask instance.
 */
+ (CBURLSessionTask *)uploadFileWithUrl:(NSString *)url
                          uploadingFile:(NSString *)uploadingFile
                          progressBlock:(CBNetWorkingProgress)progressBlock
                           successBlock:(CBResponseSuccessBlock)successBlock
                              failBlock:(CBResponseFailBlock)failBlock;

/**
 *  Download the file.
 *
 *  @param url           url.
 *  @param saveToPath    path of the file which you wanna store.
 *  @param progressBlock progress block.
 *	@param successBlock  success block.
 *	@param failBlock     fail block.
 *
 *  @return CBURLSessionTask instance.
 */
+ (CBURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                        progressBlock:(CBNetWorkingProgress)progressBlock
                         successBlock:(CBResponseSuccessBlock)successBlock
                            failBlock:(CBResponseFailBlock)failBlock;


@end

