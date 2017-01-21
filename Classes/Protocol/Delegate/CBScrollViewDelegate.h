// CBScrollViewDelegate.h
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
#import "UIScrollView+CBKit.h"

@interface CBScrollViewDelegate : NSObject <UIScrollViewDelegate>

/**
 *  Real delegate of UIScrollView.
 */
@property (nonatomic, weak, readwrite) id realDelegate;

/**
 *  Called when start scrolling.
 */
@property (nonatomic, copy, readwrite) void(^cb_scrollViewDidScrollBlock)(UIScrollView *s);

/**
 *  Called when end the animation.
 */
@property (nonatomic, copy, readwrite) void(^cb_scrollViewDidEndScrollingAnimationBlock)(UIScrollView *s);

/**
 *  Will end Dragging.
 */
@property (nonatomic, copy, readwrite) void(^cb_scrollViewWillEndDraggingBlock)(UIScrollView *s, CGPoint velocity, CGPoint *targetContentOffset);

/**
 *  Did begin zooming.
 */
@property (nonatomic, copy, readwrite) void(^cb_scrollViewDidZoomBlock)(UIScrollView *s);

/**
 *  Will begin dragging.
 */
@property (nonatomic, copy, readwrite) void(^cb_scrollViewWillBeginDraggingBlock)(UIScrollView *s);

/**
 *  Will end dragging.
 */
@property (nonatomic, copy, readwrite) void(^cb_scrollViewDidEndDraggingBlock)(UIScrollView *s, BOOL decelerate);

/**
 *  Will begin decelerating.
 */
@property (nonatomic, copy, readwrite) void(^cb_scrollViewWillBeginDeceleratingBlock)(UIScrollView *s);

/**
 *  Did end decelerating.
 */
@property (nonatomic, copy, readwrite) void(^cb_scrollViewDidEndDeceleratingBlock)(UIScrollView *s);

/**
 *  Return the view for zooming.
 */
@property (nonatomic, copy, readwrite) UIView *(^cb_viewForZoomingInScrollViewBlock)(UIScrollView *s);

/**
 *  Will begin zooming.
 */
@property (nonatomic, copy, readwrite) UIView *(^cb_scrollViewWillBeginZoomingBlock)(UIScrollView *s, UIView *v);

/**
 *  Did end zoomig.
 */
@property (nonatomic, copy, readwrite) UIView *(^cb_scrollViewDidEndZoomingBlock)(UIScrollView *s, UIView *v, CGFloat scale);

/**
 *  Should scroll to top.
 */
@property (nonatomic, copy, readwrite) BOOL(^cb_scrollViewShouldScrollToTopBlock)(UIScrollView *s);

/**
 *  Did scroll to top.
 */
@property (nonatomic, copy, readwrite) void(^cb_scrollViewDidScrollToTopBlock)(UIScrollView *s);

@end
