// CBBaseViewController.m
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

#import "CBBaseViewController.h"
#import "CBCategory.h"

@interface CBBaseViewController ()

@end

@implementation CBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated {
    if (self.navigationController.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        [[super navigationController] pushViewController:viewController animated:animated];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - Methods
- (void)sendSignal:(NSString *)signal
             class:(__unsafe_unretained Class)class
         superView:(UIView *)superView {
    NSAssert(signal, @"Signal can't be nil.");
    NSAssert(signal, @"SuperView can't be nil.");
    
    [superView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (class) {
            if ([obj isKindOfClass:class]) {
                [obj setSignal:signal];
            }
        }else {
            [obj setSignal:signal];
        }
    }];
}

- (void)backToFrontViewController {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)presentWithNavigationToViewController:(UIViewController *)viewController
                                     animated:(BOOL)animated {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:nav
                       animated:animated
                     completion:nil];
}

@end
