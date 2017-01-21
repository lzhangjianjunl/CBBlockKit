//
//  UIView+CBAdditions.h
//  CBonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "CBUtilities.h"
#import "CBConstraintMaker.h"
#import "CBViewAttribute.h"

/**
 *	Provides constraint maker block
 *  and convience methods for creating CBViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface CB_VIEW (CBAdditions)

/**
 *	following properties return a new CBViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) CBViewAttribute *CB_left;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_top;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_right;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_bottom;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_leading;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_trailing;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_width;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_height;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_centerX;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_centerY;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_baseline;
@property (nonatomic, strong, readonly) CBViewAttribute *(^CB_attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) CBViewAttribute *CB_firstBaseline;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_lastBaseline;

#endif

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) CBViewAttribute *CB_leftMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_rightMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_topMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_bottomMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_leadingMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_trailingMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_centerXWithinMargins;
@property (nonatomic, strong, readonly) CBViewAttribute *CB_centerYWithinMargins;

#endif

/**
 *	a key to associate with this view
 */
@property (nonatomic, strong) id CB_key;

/**
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (instancetype)CB_closestCommonSuperview:(CB_VIEW *)view;

/**
 *  Creates a CBConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created CBConstraints
 */
- (NSArray *)CB_makeConstraints:(void(^)(CBConstraintMaker *make))block;

/**
 *  Creates a CBConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated CBConstraints
 */
- (NSArray *)CB_updateConstraints:(void(^)(CBConstraintMaker *make))block;

/**
 *  Creates a CBConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated CBConstraints
 */
- (NSArray *)CB_remakeConstraints:(void(^)(CBConstraintMaker *make))block;

@end
