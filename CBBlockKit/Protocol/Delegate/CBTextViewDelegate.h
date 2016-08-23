// CBTextViewDelegate.h
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
#import "UITextView+CBKit.h"

@interface CBTextViewDelegate : NSObject <UITextViewDelegate>

/**
 *  Real delegate of UITextView.
 */
@property (nonatomic, weak, readwrite) id realDelegate;

/**
 *  Value changed blcok.
 */
@property (nonatomic, copy) void(^cb_changeValueBlock)(UITextView *x);

/**
 *  Did begin editing block.
 */
@property (nonatomic, copy) void(^cb_didBeginEditingBlock)(UITextView *x);

/**
 *  Did end editing block.
 */
@property (nonatomic, copy) void(^cb_didEndEditingBlock)(UITextView *x);

/**
 *	Before begins editing.
 */
@property (nonatomic, copy) BOOL(^cb_shouldBeginEditingBlock)(UITextView *x);

/**
 *	Before ends editing.
 */
@property (nonatomic, copy) BOOL(^cb_shouldEndEditingBlock)(UITextView *x);
/**
 *	Text will be changed.
 */
@property (nonatomic, copy) BOOL(^cb_shouldChangeCharactersInRangeWithReplacementTextBlock)(UITextView *x, NSRange r, NSString *s);

/**
 *	Did change selecion.
 */
@property (nonatomic, copy) void(^cb_didChangeSelecionBlock)(UITextView *x);

/**
 *  Interact with text attachment in range.
 */
@property (nonatomic, copy) BOOL(^cb_shouldInteractWithTextAttachmentInRangeBlock)(UITextView *x, NSTextAttachment *a, NSRange r);

/**
 *  Interact with URL in range.
 */
@property (nonatomic, copy) BOOL(^cb_shouldInteractWithURLInRangeBlock)(UITextView *x, NSURL *u, NSRange r);

@end
