// CBCommonMacros.h
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
#import <UIKit/UIKit.h>

/**
 *  Get weak object.
 */
#define cb_weakObject(object) __weak __typeof(object) weakObject = object;

/**
 *  Get strong object.
 */
#define cb_strongObject(object) __strong __typedef(object) strongObject = object;

/**
 *  Get main thread.
 */
#define cb_mainThread (dispatch_get_main_queue())

/**
 *  Get global thread.
 */
#define cb_globalThread dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

/**
 *  Get version of the device.
 */
#define cb_iOSVersion ([UIDevice currentDevice].systemVersion.floatValue)

/**
 *  Get the height of the screen.
 */
#define cb_screenHeight ([UIScreen mainScreen].bounds.size.height)

/**
 *  Get the width of the screen.
 */
#define cb_screenWidth ([UIScreen mainScreen].bounds.size.width)

/**
 *  Get the bounds of the screen.
 */
#define cb_ScreenBounds ([UIScreen mainScreen].bounds)

/**
 *  Get the object from NSUserDefault.
 */
#define cb_userDefaults_getter(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

/**
 *  Load the image with the name of the file.
 */
#define cb_imageWithImageName(name) [UIImage imageNamed:name]

/**
 *  save the object in NSUserDefault.
 */
#define cb_userDefaults_setter(value,key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]

/**
 *  The UUID of the App.
 */
#define cb_UUID [[UIDevice currentDevice].identifierForVendor UUIDString]

/**
 *  The height of the tarBar.
 */
#define cb_tabBarHeight self.tabBarController.tabBar.bounds.size.height

/**
 *  The height of the statusBar.
 */
#define cb_statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

/**
 *  The height of the navigationBar.
 */
#define cb_navigationBar self.navigationController.navigationBar.bounds.size.height

/**
 *  Setup all keyboards status endEditing.
 */
#define cb_takeDownAllKeyboards [[[UIApplication sharedApplication] keyWindow] endEditing:YES]

/**
 *  Set the font with systemFont and size.
 */
#define cb_systemFontWithSize(size) [UIFont systemFontOfSize:size]

/**
 *  Set the font with boldFont and size.
 */
#define cb_boldFontWithSize(size) [UIFont boldSystemFontOfSize:size]

