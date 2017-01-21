// UIImage+CBKit.m
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

#import "UIImage+CBKit.h"

@implementation UIImage (CBKit)

#pragma Getter
- (CGFloat)cb_sizeWidth {
    return self.size.width;
}

- (CGFloat)cb_sizeHeight {
    return self.size.height;
}

#pragma Setter
- (void)setCb_sizeWidth:(CGFloat)cb_sizeWidth {
    if (!isnan(cb_sizeWidth)) {
        self.size = CGSizeMake(cb_sizeWidth, self.cb_sizeHeight);
    }
}

- (void)setCb_sizeHeight:(CGFloat)cb_sizeHeight {
    if (!isnan(cb_sizeHeight)) {
        self.size = CGSizeMake(self.cb_sizeWidth, cb_sizeHeight);
    }
}

- (void)setSize:(CGSize)size {
    self.size = CGSizeMake(size.width, size.height);
}

@end
