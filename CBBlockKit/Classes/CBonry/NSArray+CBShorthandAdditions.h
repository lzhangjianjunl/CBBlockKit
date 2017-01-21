//
//  NSArray+CBShorthandAdditions.h
//  CBonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "NSArray+CBAdditions.h"

#ifdef CB_SHORTHAND

/**
 *	Shorthand array additions without the 'CB_' prefixes,
 *  only enabled if CB_SHORTHAND is defined
 */
@interface NSArray (CBShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(CBConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(CBConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(CBConstraintMaker *make))block;

@end

@implementation NSArray (CBShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(CBConstraintMaker *))block {
    return [self CB_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(^)(CBConstraintMaker *))block {
    return [self CB_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(^)(CBConstraintMaker *))block {
    return [self CB_remakeConstraints:block];
}

@end

#endif
