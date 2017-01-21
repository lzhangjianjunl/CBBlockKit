// CBCollectionDataSourse.h
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
#import "UICollectionView+CBKit.h"

@interface CBCollectionDataSourse : NSObject <UICollectionViewDataSource>

/**
 *  Real dataSourse of UITableView.
 */
@property (nonatomic, weak, readwrite) id realDataSourse;

/**
 *  Init method.
 *
 *  @param cellIdentifier the identifier of cells.
 *
 *  @return dataSourse instance.
 */
- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier;

/**
 *  Return the number of section.
 */
@property (nonatomic, copy) NSInteger(^cb_numberOfItemsInSectionBlock)(UICollectionView *c, NSInteger section);

/**
 *  Item configure block.
 */
@property (nonatomic, copy) void(^cb_collectionViewCellConfigureBlock)(id cell);

/**
 *  Return the number of section.
 */
@property (nonatomic, copy) NSInteger(^cb_numberOfSectionBlock)(UICollectionView *c);

/**
 *  Return the view of header or footer.
 */
@property (nonatomic, copy) BOOL(^cb_canMoveItemAtIndexPathBlock)(UICollectionView *c, NSIndexPath *indexPath);

/**
 *  Move to item block.
 */
@property (nonatomic, copy) BOOL(^cb_moveItemAtIndexPathBlock)(UICollectionView *c, NSIndexPath *sourceIndexPath, NSIndexPath *toIndexPath);

@end
