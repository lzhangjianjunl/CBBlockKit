// UITableView+CBKit.m
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

#import "UITableView+CBKit.h"
#import "UIView+CBKit.h"

@implementation UITableView (CBKit)

#pragma - Methods
+ (instancetype)cb_makeTableViewWithStyle:(UITableViewStyle)style
                           cellIdentifier:(NSString *)cellIdentifier
                                addToView:(UIView *)addToView
                                attribute:(void(^)(UITableView *t, CBTableViewDelegate *d, CBTableViewDataSourse *s))attribute
                               constraint:(void(^)(MASConstraintMaker *make))constraint
                             numberOfRows:(NSInteger (^)(UITableView *, NSInteger))numberOfRows
                            configureCell:(void (^)(id cell, NSIndexPath *indexPath))configureCell {
    return [self cb_makeTableViewWithStyle:style
                            cellIdentifier:cellIdentifier
                                  delegate:nil
                                 addToView:addToView
                                 attribute:attribute
                                constraint:constraint
                              numberOfRows:numberOfRows
                             configureCell:configureCell];
}

+ (instancetype)cb_makeTableViewWithStyle:(UITableViewStyle)style
                           cellIdentifier:(NSString *)cellIdentifier
                                 delegate:(id)delegate
                                addToView:(UIView *)addToView
                                attribute:(void(^)(UITableView *t, CBTableViewDelegate *d, CBTableViewDataSourse *s))attribute
                               constraint:(void(^)(MASConstraintMaker *make))constraint
                             numberOfRows:(NSInteger (^)(UITableView *, NSInteger))numberOfRows
                            configureCell:(void (^)(id cell, NSIndexPath *indexPath))configureCell {
    NSAssert(addToView, @"AddToView can't be nil.");
    NSAssert(configureCell, @"ConfigureCell block can't be nil.");
    
    static CBTableViewDataSourse *tableViewDataSourse;
    static CBTableViewDelegate *tableViewDelegate;
    
    tableViewDataSourse = [[CBTableViewDataSourse alloc] initWithCellIdentifier:cellIdentifier];
    tableViewDelegate = [[CBTableViewDelegate alloc] init];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    tableViewDataSourse.realDataSourse = delegate;
    tableViewDelegate.realDelegate = delegate;
    tableViewDataSourse.cb_tableViewCellConfigureBlock = configureCell;
    tableViewDataSourse.cb_numberOfRowsInSectionBlock = numberOfRows;
    tableView.delegate = tableViewDelegate;
    tableView.dataSource = tableViewDataSourse;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.tableFooterView = footView;
    [addToView addSubview:tableView];
    
    attribute ? attribute(tableView, tableViewDelegate, tableViewDataSourse): NSLog(@"Attribute Block is nil.");
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        constraint ? constraint(make) : NSLog(@"Constraint Block is nil.");
    }];
    
    return tableView;
}

@end
