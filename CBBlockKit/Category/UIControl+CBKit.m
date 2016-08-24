// UIControl+CBKit.m
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

#import "UIControl+CBKit.h"
#import <objc/runtime.h>

@implementation UIControl (CBKit)

#pragma - Getter
- (CBActionBlock)cb_touchUpInsideBlock {
    return objc_getAssociatedObject(self, @"cb_touchUpInsideBlock");;
}

- (CBActionBlock)cb_valueChangedBlock {
    return objc_getAssociatedObject(self, @"cb_valueChangedBlock");;
}

- (CBActionBlock)cb_valueEditingChangedBlock {
    return objc_getAssociatedObject(self, @"cb_valueEditingChangedBlock");;
}

#pragma - Setter
- (void)setCb_valueChangedBlock:(CBActionBlock)cb_valueChangedBlock {
    objc_setAssociatedObject(self,
                             @"cb_valueChangedBlock",
                             cb_valueChangedBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self
                action:@selector(valueChanged:)
      forControlEvents:UIControlEventValueChanged];
    
    if (cb_valueChangedBlock) {
        [self addTarget:self
                 action:@selector(valueChanged:)
       forControlEvents:UIControlEventValueChanged];
    }
}

- (void)setCb_touchUpInsideBlock:(CBActionBlock)cb_touchUpInsideBlock {
    objc_setAssociatedObject(self,
                             @"cb_touchUpInsideBlock",
                             cb_touchUpInsideBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self
                action:@selector(touchUpInside:)
      forControlEvents:UIControlEventTouchUpInside];
    
    if (cb_touchUpInsideBlock) {
        [self addTarget:self
                 action:@selector(touchUpInside:)
       forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setCb_valueEditingChangedBlock:(CBActionBlock)cb_valueEditingChangedBlock {
    objc_setAssociatedObject(self,
                             @"cb_valueEditingChangedBlock",
                             cb_valueEditingChangedBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self
                action:@selector(valueEditingChanged:)
      forControlEvents:UIControlEventEditingChanged];
    
    if (cb_valueEditingChangedBlock) {
        [self addTarget:self
                 action:@selector(valueEditingChanged:)
       forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)valueChanged:(id)sender {
    if (self.cb_valueChangedBlock) {
        self.cb_valueChangedBlock(self);
    }
}

- (void)touchUpInside:(id)sender {
    if (self.cb_touchUpInsideBlock) {
        self.cb_touchUpInsideBlock(self);
    }
}

- (void)valueEditingChanged:(id)sender {
    if (self.cb_valueEditingChangedBlock) {
        self.cb_valueEditingChangedBlock(self);
    }
}

@end
