// UITextField+CBKit.m
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

#import "UITextField+CBKit.h"

@implementation UITextField (CBKit)

#pragma - Methods

+ (instancetype)cb_makeTextFieldWithHolder:(NSString *)holder
                                 addToView:(UIView *)addToView
                                 attribute:(void(^)(UITextField *f, CBTextFieldDelegate *d))attribute
                                constraint:(void(^)(MASConstraintMaker *make))constraint {
    return [self cb_makeTextFieldWithHolder:holder
                                   delegate:nil 
                                  addToView:addToView
                                  attribute:attribute
                                 constraint:constraint];
}

+ (instancetype)cb_makeTextFieldWithHolder:(NSString *)holder
                                  delegate:(id<UITextFieldDelegate>)delegate
                                 addToView:(UIView *)addToView
                                 attribute:(void(^)(UITextField *f, CBTextFieldDelegate *d))attribute
                                constraint:(void(^)(MASConstraintMaker *make))constraint {
    NSAssert(addToView, @"AddToView can't be nil");
    
    UITextField *textField = [[UITextField alloc] init];
    
    static CBTextFieldDelegate *textFieldDelegate;
    
    textFieldDelegate = [[CBTextFieldDelegate alloc] init];
    
    textField.delegate = textFieldDelegate;
    
    textFieldDelegate.realDelegate = delegate;
    
    textField.borderStyle = UITextBorderStyleNone;
    
    textField.leftView = [[UIView alloc] init];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.leftView.backgroundColor = [UIColor clearColor];
    
    textField.leftView.cb_sizeWidth = 8.f;
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    textField.spellCheckingType = UITextSpellCheckingTypeNo;
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    textField.placeholder = holder;
    
    [addToView addSubview:textField];
    
    attribute ? attribute(textField, textFieldDelegate) : NSLog(@"Attribute Block is nil.");
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        constraint ? constraint(make) : NSLog(@"Constraint Block is nil.");
    }];
    
    return textField;
}

@end
