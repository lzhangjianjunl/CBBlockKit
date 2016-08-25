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

@implementation UIView (CBKit)

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
    return objc_getAssociatedObject(self, @"cb_singleTapBlock");;
}

- (CBGestureBlock)cb_doubleTapBlock {
    return objc_getAssociatedObject(self, @"cb_doubleTapBlock");;
}

- (CBGestureBlock)cb_longPressBlock {
    return objc_getAssociatedObject(self, @"cb_longPressBlock");;
}

- (CBGestureBlock)cb_panBlock {
    return objc_getAssociatedObject(self, @"cb_panBlock");;
}

- (CBEventMonitorBlock)cb_eventMonitor {
    return objc_getAssociatedObject(self, @"cb_eventMonitor");;
}

- (NSString *)cb_signal {
    return objc_getAssociatedObject(self, @"cb_signal");;
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
    objc_setAssociatedObject(self,
                             @"cb_singleTapBlock",
                             cb_singleTapBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (cb_singleTapBlock) {
        UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)[self searchSpedifiedGestureWithGestureClass:[UITapGestureRecognizer class]
                                                                                                        numOfTouch:1];
        if (!singleTap) {
            singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(singTapAction:)];
        }
        
        [self removeGestureRecognizer:singleTap];
        
        [self addGestureRecognizer:singleTap];
    }
}

- (void)setCb_doubleTapBlock:(CBGestureBlock)cb_doubleTapBlock {
    objc_setAssociatedObject(self,
                             @"cb_doubleTapBlock",
                             cb_doubleTapBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);

    if (cb_doubleTapBlock) {
        UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)[self searchSpedifiedGestureWithGestureClass:[UITapGestureRecognizer class]
                                                                                                        numOfTouch:1];
        
        UITapGestureRecognizer *doubleTap = (UITapGestureRecognizer *)[self searchSpedifiedGestureWithGestureClass:[UITapGestureRecognizer class]
                                                                                                        numOfTouch:2];
        if (!doubleTap) {
            doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(doubleTapAction:)];
        }
        
        doubleTap.numberOfTapsRequired = 2;
        
        if (singleTap) {
            [singleTap requireGestureRecognizerToFail:doubleTap];
        }
        [self removeGestureRecognizer:doubleTap];

        [self addGestureRecognizer:doubleTap];
    }
}

- (void)setCb_longPressBlock:(CBGestureBlock)cb_longPressBlock {
    objc_setAssociatedObject(self,
                             @"cb_longPressBlock",
                             cb_longPressBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (cb_longPressBlock) {
        UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)[self searchSpedifiedGestureWithGestureClass:[UILongPressGestureRecognizer class]
                                                                                                                    numOfTouch:0];
        if (!longPress) {
            longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                      action:@selector(longPressAction:)];
        }
        [self removeGestureRecognizer:longPress];
        
        [self addGestureRecognizer:longPress];
    }
}

- (void)setCb_panBlock:(CBGestureBlock)cb_panBlock {
    objc_setAssociatedObject(self,
                             @"cb_panBlock",
                             cb_panBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (cb_panBlock) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)[self searchSpedifiedGestureWithGestureClass:[UIPanGestureRecognizer class] numOfTouch:0];
        
        if (!pan) {
            pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(panAction:)];
        }
        [self removeGestureRecognizer:pan];

        [self addGestureRecognizer:pan];
    }
}

- (void)setCb_eventMonitor:(CBEventMonitorBlock)cb_eventMonitor {
    objc_setAssociatedObject(self,
                             @"cb_eventMonitor",
                             cb_eventMonitor,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setCb_signal:(NSString *)cb_signal {
    objc_setAssociatedObject(self,
                             @"cb_signal",
                             cb_signal,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (self.cb_eventMonitor) {
        self.cb_eventMonitor(self, cb_signal);
    }
}


#pragma - Gesture Method
- (void)singTapAction:(id)sender {
    if (self.cb_singleTapBlock) {
        self.cb_singleTapBlock(self);
    }
}

- (void)doubleTapAction:(id)sender {
    if (self.cb_doubleTapBlock) {
        self.cb_doubleTapBlock(self);
    }
}

- (void)longPressAction:(id)sender {
    if (self.cb_longPressBlock) {
        self.cb_longPressBlock(self);
    }
}

- (void)panAction:(id)sender {
    if (self.cb_panBlock) {
        self.cb_panBlock(self);
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

- (UIGestureRecognizer *)searchSpedifiedGestureWithGestureClass:(Class)gestureClass
                                                     numOfTouch:(NSInteger)numOfTouch {
    __block UIGestureRecognizer *gestureObj;
    
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:gestureClass]) {
            if (gestureClass == [UITapGestureRecognizer class]) {
                if (numOfTouch) {
                    if ([obj numberOfTouches] == numOfTouch) {
                        gestureObj = obj;
                    }
                }
            }else {
                gestureObj = obj;
            }
        }
    }];
    return gestureObj;
}

@end
