// UIView+CBKit.h
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
#import <objc/runtime.h>
#import "Masonry.h"

@interface UIView (CBKit)

/**
 *  UIView Gesture Block.
 *
 *  @param sender UIGestureRecognizer instacne.
 */
typedef void(^CBGestureBlock)(id s);

/**
 *  UIView EventMonitor Block.
 *
 *  @param signal specified signal.
 */
typedef void(^CBEventMonitorBlock)(id object, id signal);

/**
 *  The signal used to monitor event.
 */
@property (nonatomic, copy) NSString *cb_signal;

/**
 *  The singleTap block.
 */
@property (nonatomic, copy) CBGestureBlock cb_singleTapBlock;

/**
 *  The doubleTap block.
 */
@property (nonatomic, copy) CBGestureBlock cb_doubleTapBlock;

/**
 *  The longPress block.
 */
@property (nonatomic, copy) CBGestureBlock cb_longPressBlock;

/**
 *  The pan block.
 */
@property (nonatomic, copy) CBGestureBlock cb_panBlock;

/**
 *  The event monitor event.
 */
@property (nonatomic, copy) CBEventMonitorBlock cb_eventMonitor;

/**
 *  The X of origin.
 */
@property (nonatomic, assign, readwrite) CGFloat cb_originLeft;

/**
 *  The Y of origin.
 */
@property (nonatomic, assign, readwrite) CGFloat cb_originUp;

/**
 *  The X of origin + The size of width.
 */
@property (nonatomic, assign, readwrite) CGFloat cb_originRight;

/**
 *  The Y of origin + The size of height.
 */
@property (nonatomic, assign, readwrite) CGFloat cb_originDown;

/**
 *  The width of size.
 */
@property (nonatomic, assign, readwrite) CGFloat cb_sizeWidth;

/**
 *  The height of size.
 */
@property (nonatomic, assign, readwrite) CGFloat cb_sizeHeight;

/**
 *  The origin.
 */
@property (nonatomic, assign, readwrite) CGPoint cb_origin;

/**
 *  The size.
 */
@property (nonatomic, assign, readwrite) CGSize  cb_size;

/**
 *  The X origin of center point.
 */
@property (nonatomic, assign, readwrite) CGFloat cb_centerX;

/**
 *  The Y origin of center point.
 */
@property (nonatomic, assign, readwrite) CGFloat cb_centerY;

/**
 *  The ViewControll object which self was added to.
 *
 *  @return ViewControll object.
 */
- (UIViewController *)cb_viewController;

/**
 *  Signal setter method.
 *
 *  @param signal specified signal.
 */
- (void)setSignal:(NSString *)signal;

@end
