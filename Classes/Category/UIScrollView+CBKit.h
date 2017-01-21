// UIScrollView+CBKit.h
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
#import "CBScrollViewDelegate.h"

@class CBScrollViewDelegate;

@interface UIScrollView (CBKit)

/**
 *  Creat a UIScrollView object with attribute block.
 *
 *  @param delegate  the delegate of UIScrollView.
 *  @param addToView the specified view which one the label will be added to.
 *  @param attribute replenish and modifiy attributes of the scrollView.
 *  @param constraint the constraint of label.
 *
 *  @return UIScrollView instance.
 */
+ (instancetype)cb_makeScrollViewWithAddToView:(UIView *)addToView
                                     attribute:(void(^)(UIScrollView *s, CBScrollViewDelegate *d))attribute
                                    constraint:(void(^)(CBConstraintMaker *make))constraint;
/**
 *  Creat a UIScrollView object with delegate, attribute block.
 *
 *  @param delegate  the delegate of UIScrollView.
 *  @param addToView the specified view which one the label will be added to.
 *  @param attribute replenish and modifiy attributes of the scrollView.
 *  @param constraint the constraint of label.
 *
 *  @return UIScrollView instance.
 */
+ (instancetype)cb_makeScrollViewWithDelegate:(id)delegate
                                    addToView:(UIView *)addToView
                                    attribute:(void(^)(UIScrollView *s, CBScrollViewDelegate *d))attribute
                                   constraint:(void(^)(CBConstraintMaker *make))constraint;
@end
