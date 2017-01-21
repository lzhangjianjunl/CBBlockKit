// CBTextFieldDelegate.h
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
#import "UITextField+CBKit.h"

@interface CBTextFieldDelegate : NSObject <UITextFieldDelegate>

/**
 *  Real delegate of UITextField.
 */
@property (nonatomic, weak) id realDelegate;

/**
 *  Did begin editing block.
 */
@property (nonatomic, copy) void(^cb_didBeginEditingBlock)(UITextField *f);

/**
 *  Did end editing block.
 */
@property (nonatomic, copy) void(^cb_didEndEditingBlock  )(UITextField *f);

/**
 *	Before begins editing block.
 */
@property (nonatomic, copy) BOOL(^cb_shouldBeginEditingBlock)(UITextField *f);

/**
 *	Before ends editing block.
 */
@property (nonatomic, copy) BOOL(^cb_shouldEndEditingBlock)(UITextField *f);

/**
 *	Text will change block.
 */
@property (nonatomic, copy) BOOL(^cb_shouldChangeCharactersInRangeWithReplacementStringBlock)(UITextField *f, NSRange r, NSString *s);

/**
 *	Clear button is pressed block.
 */
@property (nonatomic, copy) BOOL(^cb_shouldClearBlock)(UITextField *f);

/**
 *	Keyboard's return button block.
 */
@property (nonatomic, copy) BOOL(^cb_shouldReturnBlock)(UITextField *f);

@end
