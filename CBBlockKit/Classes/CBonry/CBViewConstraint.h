//
//  CBConstraint.h
//  CBonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "CBViewAttribute.h"
#import "CBConstraint.h"
#import "CBLayoutConstraint.h"
#import "CBUtilities.h"

/**
 *  A single constraint.
 *  Contains the attributes neccessary for creating a NSLayoutConstraint and adding it to the appropriate view
 */
@interface CBViewConstraint : CBConstraint <NSCopying>

/**
 *	First item/view and first attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) CBViewAttribute *firstViewAttribute;

/**
 *	Second item/view and second attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) CBViewAttribute *secondViewAttribute;

/**
 *	initialises the CBViewConstraint with the first part of the equation
 *
 *	@param	firstViewAttribute	view.CB_left, view.CB_width etc.
 *
 *	@return	a new view constraint
 */
- (id)initWithFirstViewAttribute:(CBViewAttribute *)firstViewAttribute;

/**
 *  Returns all CBViewConstraints installed with this view as a first item.
 *
 *  @param  view  A view to retrieve constraints for.
 *
 *  @return An array of CBViewConstraints.
 */
+ (NSArray *)installedConstraintsForView:(CB_VIEW *)view;

@end
