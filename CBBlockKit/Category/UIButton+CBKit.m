// UIButton+CBKit.m
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

#import "UIButton+CBKit.h"
#import "CBCommonMacros.h"

@implementation UIButton (CBKit)

+ (instancetype)cb_makeButtonWithTitle:(NSString *)title
                            titleColor:(UIColor *)titleColor
                       backgroundColor:(UIColor *)backgroundColor
                             addToView:(UIView *)addToView
                             attribute:(void(^)(UIButton *b))attribute
                            constraint:(void(^)(MASConstraintMaker *make))constraint {
    return [self cb_makeButtonWithTitle:title
                             titleColor:titleColor
                        backgroundColor:backgroundColor
                              addToView:addToView
                              attribute:attribute
                             constraint:constraint
                          touchUpInside:nil];
}

+ (instancetype)cb_makeButtonWithTitle:(NSString *)title
                            titleColor:(UIColor *)titleColor
                       backgroundColor:(UIColor *)backgroundColor
                             addToView:(UIView *)addToView
                             attribute:(void(^)(UIButton *b))attribute
                            constraint:(void(^)(MASConstraintMaker *make))constraint
                         touchUpInside:(CBActionBlock)touchUpInside {
    NSAssert(addToView, @"AddToView can't be nil");

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = cb_systemFontWithSize(15.f);
    button.cb_touchUpInsideBlock = touchUpInside;
    
    if (title.length) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    
    if (backgroundColor) {
        [button setBackgroundColor:backgroundColor];
    }
    
    [addToView addSubview:button];
    
    attribute ? attribute(button) : NSLog(@"Attribute Block is nil.");
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        constraint ? constraint(make) : nil;
    }];
    
    return button;
}
@end
