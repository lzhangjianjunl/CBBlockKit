// CBBaseViewController.h
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

#import <UIKit/UIKit.h>

@interface CBBaseViewController : UIViewController

/**
 *  By using this method, we can easily set the specified view's event signal in VC.
 *
 *  @param signal    signal string.
 *  @param class     the specified view's class. Can be nil.
 *  @param superView the super view which the specified view was added to.
 */
- (void)sendSignal:(NSString *)signal
             class:(Class)class
            superView:(UIView *)superView;

/**
 *  Used to pod or dimiss the VC.
 */
- (void)backToFrontViewController;

/**
 *  Present the viewController with navigationBar;
 *
 *  @param viewController point VC.
 *  @param animated       animated.
 */
- (void)presentWithNavigationToViewController:(UIViewController *)viewController
                                     animated:(BOOL)animated;


@end
