//
//  CBCompositeConstraint.h
//  CBonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "CBConstraint.h"
#import "CBUtilities.h"

/**
 *	A group of CBConstraint objects
 */
@interface CBCompositeConstraint : CBConstraint

/**
 *	Creates a composite with a predefined array of children
 *
 *	@param	children	child CBConstraints
 *
 *	@return	a composite constraint
 */
- (id)initWithChildren:(NSArray *)children;

@end
