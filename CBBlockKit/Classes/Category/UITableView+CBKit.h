// UITableView+CBKit.h
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
#import "CBTableViewDelegate.h"
#import "CBTableViewDataSourse.h"

@class CBTableViewDelegate, CBTableViewDataSourse;

@interface UITableView (CBKit)

/**
 *  Creat a UITableView object with style, items, attribute block, constraint block, configureCell block.
 *
 *  @param style              UITableViewStyle.
 *  @param addToView          the specified view which one the label will be added to.
 *  @param attribute          replenish and modifiy attributes of the textView.
 *  @param constraint         the constraint of label.
 *  @param configureCell      return the method used to configure the cell.
 *  @param numberOfRows       the number of row in section.
 *
 *  @return UITableView instance.
 */
+ (instancetype)cb_makeTableViewWithStyle:(UITableViewStyle)style
                           cellIdentifier:(NSString *)cellIdentifier
                                addToView:(UIView *)addToView
                                attribute:(void(^)(UITableView *t, CBTableViewDelegate *d, CBTableViewDataSourse *s))attribute
                               constraint:(void(^)(CBConstraintMaker *make))constraint
                             numberOfRows:(NSInteger (^)(UITableView *t, NSInteger section))numberOfRows
                            configureCell:(void (^)(id cell, NSIndexPath *indexPath))configureCell;

/**
 *  Creat a UITableView object with style, items, delegate, attribute block, constraint block, configureCell block.
 *
 *  @param style              UITableViewStyle.
 *  @param delegate           the delegate of UITableView.
 *  @param addToView          the specified view which one the label will be added to.
 *  @param attribute          replenish and modifiy attributes of the textView.
 *  @param constraint         the constraint of label.
 *  @param configureCell      return the method used to configure the cell.
 *  @param numberOfRows       the number of row in section.
 *
 *  @return UITableView instance.
 */
+ (instancetype)cb_makeTableViewWithStyle:(UITableViewStyle)style
                           cellIdentifier:(NSString *)cellIdentifier
                                 delegate:(id)delegate
                                addToView:(UIView *)addToView
                                attribute:(void(^)(UITableView *t, CBTableViewDelegate *d, CBTableViewDataSourse *s))attribute
                               constraint:(void(^)(CBConstraintMaker *make))constraint
                             numberOfRows:(NSInteger (^)(UITableView *t, NSInteger section))numberOfRows
                            configureCell:(void (^)(id cell, NSIndexPath *indexPath))configureCell;

@end
