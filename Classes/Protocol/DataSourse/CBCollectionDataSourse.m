// CBCollectionDataSourse.m
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

#import "CBCollectionDataSourse.h"

@interface CBCollectionDataSourse()

@property (nonatomic, copy, readwrite) NSString *cellIdentifier;

@end

@implementation CBCollectionDataSourse

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier {
    self = [super init];
    
    if (self) {
        _cellIdentifier = cellIdentifier;
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    NSInteger numOfSection;
    
    if (_realDataSourse && [_realDataSourse respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        numOfSection = [_realDataSourse collectionView:collectionView numberOfItemsInSection:section];
    }else {
        if (_cb_numberOfItemsInSectionBlock) {
            
            numOfSection = _cb_numberOfItemsInSectionBlock(collectionView, section);
        }else {
            NSAssert(_cb_numberOfItemsInSectionBlock, @"NumberOfRowsInSectionBlock can't be nil.");
        }
    }
    return numOfSection;
} 

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    
    if (_realDataSourse && [_realDataSourse respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]) {
        cell = [_realDataSourse cellForItemAtIndexPath:indexPath];
    }else {
        if (_cb_collectionViewCellConfigureBlock) {
            
            if (_cb_collectionViewCellConfigureBlock) {
                _cb_collectionViewCellConfigureBlock(cell);
            }
        }else {
            NSAssert(_cb_collectionViewCellConfigureBlock, @"CollectionViewCellConfigureBlock can't be nil.");
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger numOfSection = 1;
    
    if (_realDataSourse && [_realDataSourse respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        numOfSection = [_realDataSourse numberOfSectionsInCollectionView:collectionView];
    }else {
        if (_cb_numberOfSectionBlock) {
            numOfSection = _cb_numberOfSectionBlock(collectionView);
        }
    }
    if (numOfSection <= 0) {
        numOfSection = 1;
    }
    return numOfSection;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL should = YES;
    
    if (_realDataSourse && [_realDataSourse respondsToSelector:@selector(collectionView:canMoveItemAtIndexPath:)]) {
        should = [_realDataSourse collectionView:collectionView canMoveItemAtIndexPath:indexPath];
    }
    
    if (_cb_canMoveItemAtIndexPathBlock) {
        should &= _cb_canMoveItemAtIndexPathBlock(collectionView, indexPath);
    }
    
    return should;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    if (_realDataSourse && [_realDataSourse respondsToSelector:@selector(collectionView:moveItemAtIndexPath:toIndexPath:)]) {
        [_realDataSourse collectionView:collectionView
                    moveItemAtIndexPath:sourceIndexPath
                            toIndexPath:destinationIndexPath];
    }
    if (_cb_moveItemAtIndexPathBlock) {
        _cb_moveItemAtIndexPathBlock(collectionView, sourceIndexPath, destinationIndexPath);
    }
}


@end
