// UICollectionView+CBKit.m
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

#import "UICollectionView+CBKit.h"
#import "UIView+CBKit.h"

@implementation UICollectionView (CBKit)

#pragma - Methods
+ (instancetype)cb_makeCollectionViewWithHorizontal:(BOOL)isHorizontal
                                     cellIdentifier:(NSString *)cellIdentifier
                                           delegate:(id)delegate
                                           itemSize:(CGSize)itemSize
                                          addToView:(UIView *)addToView
                                         constraint:(void(^)(MASConstraintMaker *make))constraint
                                          numOfItem:(NSInteger (^)(UICollectionView *, NSInteger))numOfItem
                                      configureCell:(void (^)(id))configureCell {
    return [self cb_makeCollectionViewWithHorizontal:isHorizontal
                                      cellIdentifier:cellIdentifier
                                            delegate:delegate
                                            itemSize:itemSize
                             minimumInteritemSpacing:0.f
                                  minimumLineSpacing:0.f
                                           addToView:addToView
                                          constraint:constraint
                                           numOfItem:numOfItem
                                       configureCell:configureCell];
}

+ (instancetype)cb_makeCollectionViewWithHorizontal:(BOOL)isHorizontal
                                     cellIdentifier:(NSString *)cellIdentifier
                                           delegate:(id)delegate
                                           itemSize:(CGSize)itemSize
                            minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
                                 minimumLineSpacing:(CGFloat)minimumLineSpacing
                                          addToView:(UIView *)addToView
                                         constraint:(void(^)(MASConstraintMaker *make))constraint
                                          numOfItem:(NSInteger (^)(UICollectionView *, NSInteger))numOfItem
                                      configureCell:(void (^)(id))configureCell {
    return [self cb_makeCollectionViewWithHorizontal:isHorizontal
                                      cellIdentifier:cellIdentifier
                                            delegate:delegate
                                            itemSize:itemSize
                             minimumInteritemSpacing:minimumInteritemSpacing
                                  minimumLineSpacing:minimumLineSpacing
                                           addToView:addToView
                                           attribute:nil
                                          constraint:constraint
                                           numOfItem:numOfItem
                                       configureCell:configureCell];
}

+ (instancetype)cb_makeCollectionViewWithHorizontal:(BOOL)isHorizontal
                                     cellIdentifier:(NSString *)cellIdentifier
                                           delegate:(id)delegate
                                           itemSize:(CGSize)itemSize
                            minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
                                 minimumLineSpacing:(CGFloat)minimumLineSpacing
                                          addToView:(UIView *)addToView
                                          attribute:(void(^)(UICollectionView *c, CBCollectionViewDelegate *d, CBCollectionDataSourse *s))attribute
                                         constraint:(void(^)(MASConstraintMaker *make))constraint
                                          numOfItem:(NSInteger (^)(UICollectionView *, NSInteger))numOfItem
                                      configureCell:(void (^)(id))configureCell {
    NSAssert(addToView, @"AddToView can't be nil");
    
    static CBCollectionViewDelegate *collectionViewDelegate;
    static CBCollectionDataSourse *collectionViewDataSourse;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = itemSize;
    layout.minimumInteritemSpacing = minimumInteritemSpacing;
    layout.minimumLineSpacing = minimumLineSpacing;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    collectionViewDelegate = [[CBCollectionViewDelegate alloc] init];
    collectionViewDelegate.realDelegate = delegate;
    
    collectionViewDataSourse = [[CBCollectionDataSourse alloc] initWithCellIdentifier:cellIdentifier];
    collectionViewDataSourse.realDataSourse = delegate;
    collectionViewDataSourse.cb_numberOfItemsInSectionBlock = numOfItem;
    collectionViewDataSourse.cb_collectionViewCellConfigureBlock = configureCell;
    
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    if (isHorizontal) {
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        collection.showsVerticalScrollIndicator = NO;
        collection.showsHorizontalScrollIndicator = YES;
    }else {
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        collection.showsVerticalScrollIndicator = YES;
        collection.showsHorizontalScrollIndicator = NO;
    }
    
    collection.backgroundColor = [UIColor whiteColor];
    collection.pagingEnabled = YES;
    collection.delegate = collectionViewDelegate;
    collection.dataSource = collectionViewDataSourse;
    collection.showsHorizontalScrollIndicator = NO;
    [addToView addSubview:collection];
    
    attribute ? attribute(collection, collectionViewDelegate, collectionViewDataSourse) : NSLog(@"Attribute Block is nil.");
    [collection mas_makeConstraints:^(MASConstraintMaker *make) {
        constraint ? constraint(make) : NSLog(@"Constraint Block is nil.");
    }];
    
    return collection;
}

@end
