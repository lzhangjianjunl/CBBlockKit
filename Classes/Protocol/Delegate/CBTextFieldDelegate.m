// CBTextFieldDelegate.m
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

#import "CBTextFieldDelegate.h"

@implementation CBTextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_realDelegate textFieldDidBeginEditing:textField];
    }
    if (_cb_didBeginEditingBlock) {
        _cb_didBeginEditingBlock(textField);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_realDelegate textFieldDidEndEditing:textField];
    }
    if (_cb_didEndEditingBlock) {
        _cb_didEndEditingBlock(textField);
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    BOOL should = YES;
    
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        should = [_realDelegate textFieldShouldBeginEditing:textField];
    }

    if (_cb_shouldBeginEditingBlock) {
        should &= _cb_shouldBeginEditingBlock(textField);
    }
        
    return should;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    BOOL should = YES;
    
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        should = [_realDelegate textFieldShouldEndEditing:textField];
    }
    
    if (_cb_shouldEndEditingBlock) {
        should &= _cb_shouldEndEditingBlock(textField);
    }
    
    return should;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL should = YES;
    
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        should = [_realDelegate textField:textField
            shouldChangeCharactersInRange:range
                        replacementString:string];
    }
    
    if (_cb_shouldChangeCharactersInRangeWithReplacementStringBlock) {
        should &= _cb_shouldChangeCharactersInRangeWithReplacementStringBlock(textField, range, string);
    }
    
    return should;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    BOOL should = YES;
    
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        should = [_realDelegate textFieldShouldClear:textField];
    }
    
    if (_cb_shouldClearBlock) {
        should &= _cb_shouldClearBlock(textField);
    }
    
    return should;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL should = YES;
    
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        should = [_realDelegate textFieldShouldReturn:textField];
    }
    
    if (_cb_shouldReturnBlock) {
        should &= _cb_shouldReturnBlock(textField);
    }
    
    return should;
}

@end
