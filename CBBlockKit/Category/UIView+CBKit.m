// UIView+CBKit.m
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

#import "UIView+CBKit.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIView (CBKit)

static UITapGestureRecognizer *singleTap;

static UITapGestureRecognizer *doubleTap;

static UILongPressGestureRecognizer *longPress;

static UIPanGestureRecognizer *pan;

static CBGestureBlock singleTapBlock;

static CBGestureBlock doubleTapBlock;

static CBGestureBlock longPressBlock;

static CBGestureBlock panBlock;

static CBEventMonitorBlock eventMonitor;

static NSString *inSignal;

#pragma - Getter
- (CGFloat)cb_originLeft {
    return self.frame.origin.x;
}

- (CGFloat)cb_originUp {
    return self.frame.origin.y;
}

- (CGFloat)cb_originRight {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)cb_originDown {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)cb_sizeWidth {
    return self.frame.size.width;
}

- (CGFloat)cb_sizeHeight {
    return self.frame.size.height;
}

- (CGSize)cb_size {
    return self.frame.size;
}

- (CGPoint)cb_origin {
    return self.frame.origin;
}

- (CGFloat)cb_centerX {
    return self.center.x;
}

- (CGFloat)cb_centerY {
    return self.center.y;
}

- (CBGestureBlock)cb_singleTapBlock {
    return singleTapBlock;
}

- (CBGestureBlock)cb_doubleTapBlock {
    return doubleTapBlock;
}

- (CBGestureBlock)cb_longPressBlock {
    return longPressBlock;
}

- (CBGestureBlock)cb_panBlock {
    return panBlock;
}

- (CBEventMonitorBlock)cb_eventMonitor {
    return eventMonitor;
}

- (NSString *)cb_signal {
    return inSignal;
}

#pragma - Setter
- (void)setCb_originLeft:(CGFloat)cb_originLeft {
    if (!isnan(cb_originLeft)) {
        self.frame = CGRectMake(cb_originLeft, self.cb_originUp, self.cb_sizeWidth, self.cb_sizeHeight);
    }
}

- (void)setCb_originUp:(CGFloat)cb_originUp {
    if (!isnan(cb_originUp)) {
        self.frame = CGRectMake(self.cb_originLeft, cb_originUp, self.cb_sizeWidth, self.cb_sizeHeight);
    }
}

- (void)setCb_originRight:(CGFloat)cb_originRight {
    if (!isnan(cb_originRight)) {
        self.frame = CGRectMake(cb_originRight - self.cb_sizeWidth, self.cb_originUp, self.cb_sizeWidth, self.cb_sizeHeight);
    }
}

- (void)setCb_originDown:(CGFloat)cb_originDown {
    if (!isnan(cb_originDown)) {
        self.frame = CGRectMake(self.cb_originLeft, cb_originDown - self.cb_sizeHeight, self.cb_sizeWidth, self.cb_sizeHeight);
    }
}

- (void)setCb_sizeWidth:(CGFloat)cb_sizeWidth {
    if (!isnan(cb_sizeWidth)) {
        self.frame = CGRectMake(self.cb_originLeft, self.cb_originUp, cb_sizeWidth, self.cb_sizeHeight);
    }
}

- (void)setCb_sizeHeight:(CGFloat)cb_sizeHeight {
    if (!isnan(cb_sizeHeight)) {
        self.frame = CGRectMake(self.cb_originLeft, self.cb_originUp, self.cb_sizeWidth, cb_sizeHeight);
    }
}

- (void)setCb_size:(CGSize)cb_size {
    if (!isnan(cb_size.height)) {
        self.frame = CGRectMake(self.cb_originLeft, self.cb_originUp, cb_size.width, cb_size.height);
    }
}

- (void)setCb_origin:(CGPoint)cb_origin {
    if (!isnan(cb_origin.x)) {
        self.frame = CGRectMake(cb_origin.x, cb_origin.y, self.cb_sizeWidth, self.cb_sizeHeight);
    }
}

- (void)setCb_centerX:(CGFloat)cb_centerX {
    if (!isnan(cb_centerX)) {
        self.center = CGPointMake(cb_centerX, self.center.y);
    }
}

- (void)setCb_centerY:(CGFloat)cb_centerY {
    if (!isnan(cb_centerY)) {
        self.center = CGPointMake(self.center.x, cb_centerY);
    }
}

- (void)setCb_singleTapBlock:(CBGestureBlock)cb_singleTapBlock {
    singleTapBlock = cb_singleTapBlock;
    
    if (!singleTap) {
        singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(singTapAction:)];
    }
    
    if (cb_singleTapBlock) {
        [self setUserInteractionEnabled:YES];
        
        [self addGestureRecognizer:singleTap];
    }
}

- (void)setCb_doubleTapBlock:(CBGestureBlock)cb_doubleTapBlock {
    doubleTapBlock = cb_doubleTapBlock;
    
    if (!doubleTap) {
        doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(doubleTapAction:)];
    }
    
    if (doubleTapBlock) {
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    
    doubleTap.numberOfTapsRequired = 2;
    
    [self removeGestureRecognizer:doubleTap];
    
    if (cb_doubleTapBlock) {
        [self setUserInteractionEnabled:YES];

        [self addGestureRecognizer:doubleTap];
    }
}

- (void)setCb_longPressBlock:(CBGestureBlock)cb_longPressBlock {
    longPressBlock = cb_longPressBlock;

    if (!longPress) {
        longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(longPressAction:)];
    }
    
    if (cb_longPressBlock) {
        [self setUserInteractionEnabled:YES];

        [self addGestureRecognizer:longPress];
    }
}

- (void)setCb_panBlock:(CBGestureBlock)cb_panBlock {
    panBlock = cb_panBlock;
    
    if (!pan) {
        pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(panAction:)];
    }
    
    if (cb_panBlock) {
        [self setUserInteractionEnabled:YES];
        
        [self addGestureRecognizer:pan];
    }
}

- (void)setCb_eventMonitor:(CBEventMonitorBlock)cb_eventMonitor {
    eventMonitor = cb_eventMonitor;
}

- (void)setCb_signal:(NSString *)cb_signal {
    inSignal = cb_signal;
    
    if (eventMonitor) {
        eventMonitor(self, cb_signal);
    }
}

#pragma - Common Methods
- (UIViewController *)cb_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)setSignal:(NSString *)signal {
    if (signal.length) {
        self.cb_signal = signal;
    }
}

#pragma - Gesture Method
- (void)singTapAction:(id)sender {
    if (singleTapBlock) {
        singleTapBlock(self);
    }
}

- (void)doubleTapAction:(id)sender {
    if (doubleTapBlock) {
        doubleTapBlock(self);
    }
}

- (void)longPressAction:(id)sender {
    if (longPressBlock) {
        longPressBlock(self);
    }
}

- (void)panAction:(id)sender {
    if (panBlock) {
        panBlock(self);
    }
}

@end
