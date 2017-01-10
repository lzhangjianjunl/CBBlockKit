// UITextView+CBKit.m
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

#import "UITextView+CBKit.h"

@implementation UITextView (CBKit)

#pragma - Methods
+ (instancetype)cb_makeTextViewWithAddToView:(UIView *)addToView
                                   attribute:(void(^)(UITextView *x, CBTextViewDelegate *d))attribute
                                  constraint:(void(^)(MASConstraintMaker *make))constraint {
    return [self cb_makeTextViewWithDelegate:nil
                                   addToView:addToView
                                   attribute:attribute
                                  constraint:constraint];
}

+ (instancetype)cb_makeTextViewWithDelegate:(id)delegate
                                  addToView:(UIView *)addToView
                                  attribute:(void(^)(UITextView *x, CBTextViewDelegate *d))attribute
                                 constraint:(void(^)(MASConstraintMaker *make))constraint {
    NSAssert(addToView, @"AddToView can't be nil");
    
    UITextView *textView = [[UITextView alloc] init];
    static CBTextViewDelegate *textViewDelegate;
    
    textViewDelegate = [[CBTextViewDelegate alloc] init];
    textView.delegate = textViewDelegate;
    textViewDelegate.realDelegate = delegate;
    [addToView addSubview:textView];
    
    attribute ? attribute(textView, textViewDelegate) : NSLog(@"Attribute Block is nil.");
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        constraint ? constraint(make) : NSLog(@"Constraint Block is nil.");
    }];
    
    return textView;
}

@end
