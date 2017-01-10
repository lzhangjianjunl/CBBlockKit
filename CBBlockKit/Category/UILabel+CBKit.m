// UILabel+CBKit.m
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

#import "UILabel+CBKit.h"
#import "CBCommonMacros.h"

@implementation UILabel (CBKit)

+ (instancetype)cb_makeLabelWithText:(NSString *)text
                           addToView:(UIView *)addToView
                           attribute:(void(^)(UILabel *l))attribute
                          constraint:(void(^)(MASConstraintMaker *make))constraint {
    return [self cb_makeLabelWithText:text
                             fontSize:0
                            textColor:nil
                            addToView:addToView
                            attribute:attribute
                           constraint:constraint];
}

+ (instancetype)cb_makeLabelWithText:(NSString *)text
                            fontSize:(CGFloat)fontSize
                           textColor:(UIColor *)textColor
                           addToView:(UIView *)addToView
                           attribute:(void(^)(UILabel *l))attribute
                          constraint:(void(^)(MASConstraintMaker *make))constraint {
    NSAssert(addToView, @"AddToView can't be nil");

    UILabel *label = [[UILabel alloc] init];
    label.text = text.length ? text : @"";
    label.font = fontSize ? cb_systemFontWithSize(fontSize) : cb_systemFontWithSize(15.f);
    label.textColor = textColor ? textColor : [UIColor blackColor];
    [addToView addSubview:label];
    
    attribute ? attribute(label) : NSLog(@"Attribute Block is nil.");
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        constraint ? constraint(make) : NSLog(@"Constraint block is nil");
    }];
    
    return label;
}
@end
