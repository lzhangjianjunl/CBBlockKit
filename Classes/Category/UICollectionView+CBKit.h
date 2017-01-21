// UICollectionView+CBKit.h
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
#import "UIView+CBKit.h"
#import "CBCollectionViewDelegate.h"
#import "CBCollectionDataSourse.h"

@class CBCollectionViewDelegate, CBCollectionDataSourse;

@interface UICollectionView (CBKit)

/**
 *  Creat a collectionView object with isHorizontal, delegate, itemSize, attribute block.
 *
 *  @param isHorizontal            UICollectionViewScrollDirection.
 *	@param delegate                the collectionView delegate.
 *  @param itemSize                the size of collection view cell.
 *  @param addToView               the specified view which one the label will be added to.
 *  @param constraint              the constraint of label.
 *  @param configureCell           return the method used to configure the cell.
 *  @param numOfItem               the number of item in section.
 *
 *  @return UICollectionView instance.
 */
+ (instancetype)cb_makeCollectionViewWithHorizontal:(BOOL)isHorizontal
                                     cellIdentifier:(NSString *)cellIdentifier
                                           delegate:(id)delegate
                                           itemSize:(CGSize)itemSize
                                          addToView:(UIView *)addToView
                                         constraint:(void(^)(CBConstraintMaker *make))constraint
                                          numOfItem:(NSInteger(^)(UICollectionView *c, NSInteger section))numOfItem
                                      configureCell:(void (^)(id cell))configureCell;


/**
 *  Creat a collectionView object with isHorizontal, delegate, itemSize, minimumInteritemSpacing, minimumLineSpacing.
 *
 *  @param isHorizontal            UICollectionViewScrollDirection.
 *	@param delegate                the collectionView delegate.
 *  @param itemSize                the size of collection view cell.
 *  @param minimumInteritemSpacing the minunum interitem spacing.
 *  @param minimumLineSpacing      the mininum line spacing.
 *  @param addToView               the specified view which one the label will be added to.
 *  @param constraint              the constraint of label.
 *  @param configureCell           return the method used to configure the cell.
 *  @param numOfItem               the number of item in section.
 *
 *  @return UICollectionView instance.
 */
+ (instancetype)cb_makeCollectionViewWithHorizontal:(BOOL)isHorizontal
                                     cellIdentifier:(NSString *)cellIdentifier
                                           delegate:(id)delegate
                                           itemSize:(CGSize)itemSize
                            minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
                                 minimumLineSpacing:(CGFloat)minimumLineSpacing
                                          addToView:(UIView *)addToView
                                         constraint:(void(^)(CBConstraintMaker *make))constraint
                                          numOfItem:(NSInteger(^)(UICollectionView *c, NSInteger section))numOfItem
                                      configureCell:(void (^)(id cell))configureCell;
/**
 *  Creat a collectionView object with isHorizontal, delegate, itemSize, minimumInteritemSpacing, minimumLineSpacing, attribute block.
 *
 *  @param isHorizontal            UICollectionViewScrollDirection.
 *	@param delegate                the collectionView delegate.
 *  @param itemSize                the size of collection view cell.
 *  @param minimumInteritemSpacing the minunum interitem spacing.
 *  @param minimumLineSpacing      the mininum line spacing.
 *  @param addToView               the specified view which one the label will be added to.
 *  @param attribute               replenish and modifiy attributes of the collectionView.
 *  @param constraint              the constraint of label.
 *  @param configureCell           return the method used to configure the cell.
 *  @param numOfItem               the number of item in section.
 *
 *  @return UICollectionView instance.
 */
+ (instancetype)cb_makeCollectionViewWithHorizontal:(BOOL)isHorizontal
                                     cellIdentifier:(NSString *)cellIdentifier
                                           delegate:(id)delegate
                                           itemSize:(CGSize)itemSize
                            minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
                                 minimumLineSpacing:(CGFloat)minimumLineSpacing
                                          addToView:(UIView *)addToView
                                          attribute:(void(^)(UICollectionView *c, CBCollectionViewDelegate *d, CBCollectionDataSourse *s))attribute
                                         constraint:(void(^)(CBConstraintMaker *make))constraint
                                          numOfItem:(NSInteger(^)(UICollectionView *c, NSInteger section))numOfItem
                                      configureCell:(void (^)(id cell))configureCell;

@end
