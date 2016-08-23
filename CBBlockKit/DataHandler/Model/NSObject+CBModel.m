// NSObject+CBModel.m
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

#import "NSObject+CBModel.h"
#import <objc/message.h>

@implementation NSObject (CBModel)

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary {
    NSObject *object = [[[self class] alloc] init];

    for (NSString *key in dictionary) {
        id value = dictionary[key];
        
        if ([value isEqual:[NSNull null]]) value = @"";
        
        NSString *propertSetterName = [NSString stringWithFormat:@"set%@%@",key,@":"];
        
        SEL setterSEL = NSSelectorFromString(propertSetterName);
        
        if ([self respondsToSelector:setterSEL]) {
            ((void(*)(id, SEL,id))objc_msgSend)(object, setterSEL, value);
        }
    }
    return object;
}

+ (NSArray *)modelWithWithArray:(NSArray *)array {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *singleDic in array) {
        NSObject *object = [self modelWithDictionary:singleDic];
        
        [resultArray addObject:object];
    }
    return [resultArray copy];
}

- (NSArray *)properties {
    NSMutableArray *props = [NSMutableArray array];
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    
    for (i = 0; i < outCount; i++) {
        const char *char_f = property_getName(properties[i]);
        
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        [props addObject:propertyName];
    }
    free(properties);
    
    return [props copy];
}

+ (NSDictionary *)makeDictionary {
    NSArray *propertiesArray = [self properties];
    
    NSDictionary *resultDictionary = [[NSDictionary alloc] init];
    
    for (NSString *propertiesName in propertiesArray) {
        SEL getterSEL = NSSelectorFromString(propertiesName);
        
        if ([self respondsToSelector:getterSEL]) {
            [resultDictionary setValue:objc_msgSend(self, getterSEL) forKey:propertiesName];
        }
    }
    return resultDictionary;
}

@end
