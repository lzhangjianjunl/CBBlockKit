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

static CBActionBlock valueChangedBlock;

static CBActionBlock touchUpInsideBlock;

static CBActionBlock valueEditingChangedBlock;

@implementation UIControl (CBKit)

#pragma - Getter
- (CBActionBlock)cb_touchUpInsideBlock {
    return touchUpInsideBlock;
}

- (CBActionBlock)cb_valueChangedBlock {
    return valueChangedBlock;
}

- (CBActionBlock)cb_valueEditingChangedBlock {
    return valueEditingChangedBlock;
}

#pragma - Setter
- (void)setCb_valueChangedBlock:(CBActionBlock)cb_valueChangedBlock {
    valueChangedBlock = cb_valueChangedBlock;
    
    [self removeTarget:self
                action:@selector(valueChanged:)
      forControlEvents:UIControlEventValueChanged];
    
    if (valueChangedBlock) {
        [self addTarget:self
                 action:@selector(valueChanged:)
       forControlEvents:UIControlEventValueChanged];
    }
}

- (void)setCb_touchUpInsideBlock:(CBActionBlock)cb_touchUpInsideBlock {
    touchUpInsideBlock = cb_touchUpInsideBlock;
    
    [self removeTarget:self
                action:@selector(touchUpInside:)
      forControlEvents:UIControlEventTouchUpInside];
    
    if (touchUpInsideBlock) {
        [self addTarget:self
                 action:@selector(touchUpInside:)
       forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setCb_valueEditingChangedBlock:(CBActionBlock)cb_valueEditingChangedBlock {
    valueEditingChangedBlock = cb_valueEditingChangedBlock;
    
    [self removeTarget:self
                action:@selector(valueEditingChanged:)
      forControlEvents:UIControlEventEditingChanged];
    
    if (valueEditingChangedBlock) {
        [self addTarget:self
                 action:@selector(valueEditingChanged:)
       forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)valueChanged:(id)sender {
    if (valueChangedBlock) {
        valueChangedBlock(self);
    }
}

- (void)touchUpInside:(id)sender {
    if (touchUpInsideBlock) {
        touchUpInsideBlock(self);
    }
}

- (void)valueEditingChanged:(id)sender {
    if (valueEditingChangedBlock) {
        valueEditingChangedBlock(self);
    }
}

@end
