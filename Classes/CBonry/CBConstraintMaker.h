//
//  CBConstraintBuilder.h
//  CBonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "CBConstraint.h"
#import "CBUtilities.h"

typedef NS_OPTIONS(NSInteger, CBAttribute) {
    CBAttributeLeft = 1 << NSLayoutAttributeLeft,
    CBAttributeRight = 1 << NSLayoutAttributeRight,
    CBAttributeTop = 1 << NSLayoutAttributeTop,
    CBAttributeBottom = 1 << NSLayoutAttributeBottom,
    CBAttributeLeading = 1 << NSLayoutAttributeLeading,
    CBAttributeTrailing = 1 << NSLayoutAttributeTrailing,
    CBAttributeWidth = 1 << NSLayoutAttributeWidth,
    CBAttributeHeight = 1 << NSLayoutAttributeHeight,
    CBAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    CBAttributeCenterY = 1 << NSLayoutAttributeCenterY,
    CBAttributeBaseline = 1 << NSLayoutAttributeBaseline,
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    CBAttributeFirstBaseline = 1 << NSLayoutAttributeFirstBaseline,
    CBAttributeLastBaseline = 1 << NSLayoutAttributeLastBaseline,
    
#endif
    
#if TARGET_OS_IPHONE || TARGET_OS_TV
    
    CBAttributeLeftMargin = 1 << NSLayoutAttributeLeftMargin,
    CBAttributeRightMargin = 1 << NSLayoutAttributeRightMargin,
    CBAttributeTopMargin = 1 << NSLayoutAttributeTopMargin,
    CBAttributeBottomMargin = 1 << NSLayoutAttributeBottomMargin,
    CBAttributeLeadingMargin = 1 << NSLayoutAttributeLeadingMargin,
    CBAttributeTrailingMargin = 1 << NSLayoutAttributeTrailingMargin,
    CBAttributeCenterXWithinMargins = 1 << NSLayoutAttributeCenterXWithinMargins,
    CBAttributeCenterYWithinMargins = 1 << NSLayoutAttributeCenterYWithinMargins,

#endif
    
};

/**
 *  Provides factory methods for creating CBConstraints.
 *  Constraints are collected until they are ready to be installed
 *
 */
@interface CBConstraintMaker : NSObject

/**
 *	The following properties return a new CBViewConstraint
 *  with the first item set to the makers associated view and the appropriate CBViewAttribute
 */
@property (nonatomic, strong, readonly) CBConstraint *left;
@property (nonatomic, strong, readonly) CBConstraint *top;
@property (nonatomic, strong, readonly) CBConstraint *right;
@property (nonatomic, strong, readonly) CBConstraint *bottom;
@property (nonatomic, strong, readonly) CBConstraint *leading;
@property (nonatomic, strong, readonly) CBConstraint *trailing;
@property (nonatomic, strong, readonly) CBConstraint *width;
@property (nonatomic, strong, readonly) CBConstraint *height;
@property (nonatomic, strong, readonly) CBConstraint *centerX;
@property (nonatomic, strong, readonly) CBConstraint *centerY;
@property (nonatomic, strong, readonly) CBConstraint *baseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) CBConstraint *firstBaseline;
@property (nonatomic, strong, readonly) CBConstraint *lastBaseline;

#endif

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) CBConstraint *leftMargin;
@property (nonatomic, strong, readonly) CBConstraint *rightMargin;
@property (nonatomic, strong, readonly) CBConstraint *topMargin;
@property (nonatomic, strong, readonly) CBConstraint *bottomMargin;
@property (nonatomic, strong, readonly) CBConstraint *leadingMargin;
@property (nonatomic, strong, readonly) CBConstraint *trailingMargin;
@property (nonatomic, strong, readonly) CBConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) CBConstraint *centerYWithinMargins;

#endif

/**
 *  Returns a block which creates a new CBCompositeConstraint with the first item set
 *  to the makers associated view and children corresponding to the set bits in the
 *  CBAttribute parameter. Combine multiple attributes via binary-or.
 */
@property (nonatomic, strong, readonly) CBConstraint *(^attributes)(CBAttribute attrs);

/**
 *	Creates a CBCompositeConstraint with type CBCompositeConstraintTypeEdges
 *  which generates the appropriate CBViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) CBConstraint *edges;

/**
 *	Creates a CBCompositeConstraint with type CBCompositeConstraintTypeSize
 *  which generates the appropriate CBViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) CBConstraint *size;

/**
 *	Creates a CBCompositeConstraint with type CBCompositeConstraintTypeCenter
 *  which generates the appropriate CBViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) CBConstraint *center;

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *  Whether or not to remove existing constraints prior to installing
 */
@property (nonatomic, assign) BOOL removeExisting;

/**
 *	initialises the maker with a default view
 *
 *	@param	view	any CBConstrait are created with this view as the first item
 *
 *	@return	a new CBConstraintMaker
 */
- (id)initWithView:(CB_VIEW *)view;

/**
 *	Calls install method on any CBConstraints which have been created by this maker
 *
 *	@return	an array of all the installed CBConstraints
 */
- (NSArray *)install;

- (CBConstraint * (^)(dispatch_block_t))group;

@end
