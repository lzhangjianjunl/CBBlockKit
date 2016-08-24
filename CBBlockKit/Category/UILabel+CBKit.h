// UILabel+CBKit.h
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

#import <UIKit/UIKit.h>
#import "UIView+CBKit.h"

@interface UILabel (CBKit)

/**
 *  Creat a label object with text,attribute block, constraint block.
 *
 *  @param text        the text of the label.
 *  @param addToView   the specified view which one the label will be added to.
 *  @param attribute   replenish and modifiy attributes of the label.
 *  @param constraint  the constraint of label.
 *
 *  @return UILabel instance.
 */
+ (instancetype)cb_makeLabelWithText:(NSString *)text
                           addToView:(UIView *)addToView
                           attribute:(void(^)(UILabel *l))attribute
                          constraint:(void(^)(MASConstraintMaker *make))constraint;

/**
 *  Creat a label object with text, fontSize, attribute block, constraint block.
 *
 *  @param text        the text of the label.
 *  @param fontSize    the size of the font.
 *  @param textColor   the color of the text.
 *  @param addToView   the specified view which one the label will be added to.
 *  @param attribute   replenish and modifiy attributes of the label.
 *  @param constraint  the constraint of label.
 *
 *  @return UILabel instance.
 */
+ (instancetype)cb_makeLabelWithText:(NSString *)text
                            fontSize:(CGFloat)fontSize
                           textColor:(UIColor *)textColor
                           addToView:(UIView *)addToView
                           attribute:(void(^)(UILabel *l))attribute
                          constraint:(void(^)(MASConstraintMaker *make))constraint;
@end
