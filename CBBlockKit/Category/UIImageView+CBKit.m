// UIImageView+CBKit.m
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

#import "UIImageView+CBKit.h"

@implementation UIImageView (CBKit)

#pragma - Methods
+ (instancetype)cb_makeImageViewWithImage:(id)image
                                addToView:(UIView *)addToView
                                attribute:(void(^)(UIImageView *m))attribute
                               constraint:(void(^)(MASConstraintMaker *make))constraint {
    return [self cb_makeImageViewWithImage:image
                              cornerRadius:0
                                 addToView:addToView
                                 attribute:attribute
                                constraint:constraint];
}

+ (instancetype)cb_makeImageViewWithImage:(id)image
                             cornerRadius:(CGFloat)cornerRadius
                                addToView:(UIView *)addToView
                                attribute:(void(^)(UIImageView *m))attribute
                               constraint:(void(^)(MASConstraintMaker *make))constraint {
    NSAssert(addToView, @"AddToView can't be nil");
    
    UIImageView *imgView = [[UIImageView alloc] init];
    
    if (image != nil) {
        if ([image isKindOfClass:[NSString class]]) {
            imgView.image = [UIImage imageNamed:image];
        } else {
            imgView.image = image;
        }
    }
    
    if (cornerRadius) {
        imgView.layer.cornerRadius = cornerRadius;
        
        imgView.layer.masksToBounds = YES;
        
        imgView.clipsToBounds = YES;
    }
    
    imgView.clipsToBounds = YES;
    
    imgView.userInteractionEnabled = YES;
    
    imgView.contentMode =  UIViewContentModeScaleAspectFill;
    
    imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [addToView addSubview:imgView];
    
    attribute ? attribute(imgView) : NSLog(@"Attribute Block is nil.");
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        constraint ? constraint(make) : NSLog(@"Constraint Block is nil.");
    }];
    
    return imgView;
}

@end
