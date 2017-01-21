// CBTableViewDelegate.h
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
#import "UITableView+CBKit.h"

@interface CBTableViewDelegate : NSObject <UITableViewDelegate>

/**
 *  Real delegate of UITableView.
 */
@property (nonatomic, weak, readwrite) id realDelegate;

/**
 *  Return the height of every row.
 */
@property (nonatomic, copy, readwrite) CGFloat(^cb_heightForRowBlock)(UITableView *t, NSIndexPath *indexPath);

/**
 *  Return the height of header.
 */
@property (nonatomic, copy, readwrite) CGFloat(^cb_heightForHeaderBlock)(UITableView *t, NSInteger section);

/**
 *  Return the height of footer.
 */
@property (nonatomic, copy, readwrite) CGFloat(^cb_heightForFooterBlock)(UITableView *t, NSInteger section);

/**
 *  Return the estimated height of every rows.
 */
@property (nonatomic, copy, readwrite) CGFloat(^cb_estimatedHeightForRowBlock)(UITableView *t, NSIndexPath *indexPath);

/**
 *  Return the estimated height of header.
 */
@property (nonatomic, copy, readwrite) CGFloat(^cb_estimatedHeightForHeaderBlock)(UITableView *t, NSInteger section);

/**
 *  Return the estimated height of footer.
 */
@property (nonatomic, copy, readwrite) CGFloat(^cb_estimatedHeightForFooterBlock)(UITableView *t, NSInteger section);

/**
 *  Called when cells are selected.
 */
@property (nonatomic, copy, readwrite) void(^cb_didSelectRowAtIndexPathBlock)(UITableView *t, id cell, NSIndexPath *indexPath);

/**
 *  Celled when cells are deselected.
 */
@property (nonatomic, copy, readwrite) void(^cb_didDeselectRowAtIndexPath)(UITableView *t, id cell, NSIndexPath *indexPath);

/**
 *  View for header block.
 */
@property (nonatomic, copy, readwrite) UIView *(^cb_viewForHeaderInSectionBlock)(UITableView *t, NSInteger section);

/**
 *  View for footer block.
 */
@property (nonatomic, copy, readwrite) UIView *(^cb_viewForFooterInSectionBlock)(UITableView *t, NSInteger section);

@end
