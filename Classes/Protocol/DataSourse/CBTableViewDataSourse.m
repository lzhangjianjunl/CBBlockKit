// CBTableViewDataSourse.m
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

#import "CBTableViewDataSourse.h"

@interface CBTableViewDataSourse()

@property (nonatomic, copy, readwrite) NSString *cellIdentifier;

@end

@implementation CBTableViewDataSourse

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier {
    self = [super init];
    
    if (self) {
        _cellIdentifier = cellIdentifier;
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numOfSection;
    
    if (_realDataSourse && [_realDataSourse respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        numOfSection = [_realDataSourse tableView:tableView numberOfRowsInSection:section];
    }else {
        if (_cb_numberOfRowsInSectionBlock) {

            numOfSection = _cb_numberOfRowsInSectionBlock(tableView, section);
        }else {
            NSAssert(_cb_numberOfRowsInSectionBlock, @"NumberOfRowsInSectionBlock can't be nil.");
        }
    }
    if (numOfSection <= 0) {
        numOfSection = 1;
    }
    return numOfSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (_realDataSourse && [_realDataSourse respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        cell = [_realDataSourse cellForRowAtIndexPath:indexPath];
    }else {
        if (_cb_tableViewCellConfigureBlock) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
            
            if (!cell)
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentifier];
            
            if (_cb_tableViewCellConfigureBlock) {
                _cb_tableViewCellConfigureBlock(cell, indexPath);
            }
        }else {
            NSAssert(_cb_tableViewCellConfigureBlock, @"CellForRowAtIndexPathBlock can't be nil.");
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSection = 1;
    
    if (_realDataSourse && [_realDataSourse respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        numOfSection = [_realDataSourse numberOfSectionsInTableView:tableView];
    }else {
        if (_cb_numberOfSectionBlock) {
            numOfSection = _cb_numberOfSectionBlock(tableView);
        }
    }
    if (numOfSection <= 0) {
        numOfSection = 1;
    }
    return numOfSection;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title;
    
    if (_realDataSourse && [_realDataSourse respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        title = [_realDataSourse tableView:tableView titleForHeaderInSection:section];
    }else {
        if (_cb_titleForHeaderInSectionBlock) {
            title = _cb_titleForHeaderInSectionBlock(tableView, section);
        }
    }
    return title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString *title;
    
    if (_realDataSourse && [_realDataSourse respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        title = [_realDataSourse tableView:tableView titleForFooterInSection:section];
    }else {
        if (_cb_titleForFooterInSectionBlock) {
            title = _cb_titleForFooterInSectionBlock(tableView, section);
        }
    }
    return title;
}

@end
