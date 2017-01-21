// CBCollectionViewDelegate.h
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

@interface CBCollectionViewDelegate : NSObject <UICollectionViewDelegate>

/**
 *  Real delegate of UIScrollView.
 */
@property (nonatomic, weak, readwrite) id realDelegate;

/**
 *  Did select aItem.
 */
@property (nonatomic, copy, readwrite) void(^cb_didSelectItemAtIndexPathBlock)(UICollectionView *c);

/**
 *  Did unSelect aItem.
 */
@property (nonatomic, copy, readwrite) void(^cb_didDeselectItemAtIndexPathBlock)(UICollectionView *c);

/**
 *  Should show menu for aItem.
 */
@property (nonatomic, copy, readwrite) BOOL(^cb_shouldShowMenuForItemAtIndexPathBlock)(UICollectionView *c, NSIndexPath *indexPath);

/**
 *  Can perform action.
 */
@property (nonatomic, copy, readwrite) BOOL(^cb_canPerformActionBlock)(UICollectionView *c, SEL action, NSIndexPath *indexPath, id sender);

/**
 *  Perform action.
 */
@property (nonatomic, copy, readwrite) void(^cb_performActionBlock)(UICollectionView *c, SEL action, NSIndexPath *indexPath, id sender);

/**
 *  Will display cells.
 */
@property (nonatomic, copy, readwrite) void(^cb_willDisplayCellBlock)(UICollectionView *c, UICollectionViewCell *cell, NSIndexPath *indexPath);

/**
 *  Will display supplementary view.
 */
@property (nonatomic, copy, readwrite) void(^cb_willDisplaySupplementaryViewBlock)(UICollectionView *c, UICollectionReusableView *view, NSString *elementKind, NSIndexPath *indexPath);

/**
 *  Did end displaying cell.
 */
@property (nonatomic, copy, readwrite) void(^cb_didEndDisplayingCellBlock)(UICollectionView *c, UICollectionViewCell *cell, NSIndexPath *indexPath);

/**
 *  Did end displaying supplementary view.
 */
@property (nonatomic, copy, readwrite) void(^cb_didEndDisplayingSupplementaryViewBlock)(UICollectionView *c, UICollectionReusableView *view, NSString *elementKind, NSIndexPath *indexPath);

@end
