// NSString+CBKit.h
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

@interface NSString (CBKit)

/**
 *  Encrypt String with MD5 method.
 *
 *  @return Encryped string.
 */
- (NSString *)cb_encryptStringWithMD5;

/**
 *  Whether the string is a valid kind of email format.
 *
 *  @return Yes if the string is a valid email format, ortherwise return NO.
 */
- (BOOL)cb_isEmailFormat;

/**
 *  Whether the string is a valid kind of mobile phone Number format.
 *
 *  @return Yes if the string is a valid mobile phone Number format, ortherwise return NO.
 */
- (BOOL)cb_isMobilePhoneFormat;

@end
