//
//  CBConstraint+Private.h
//  CBonry
//
//  Created by Nick Tymchenko on 29/04/14.
//  Copyright (c) 2014 cloudling. All rights reserved.
//

#import "CBConstraint.h"

@protocol CBConstraintDelegate;


@interface CBConstraint ()

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *	Usually CBConstraintMaker but could be a parent CBConstraint
 */
@property (nonatomic, weak) id<CBConstraintDelegate> delegate;

/**
 *  Based on a provided value type, is equal to calling:
 *  NSNumber - setOffset:
 *  NSValue with CGPoint - setPointOffset:
 *  NSValue with CGSize - setSizeOffset:
 *  NSValue with CBEdgeInsets - setInsets:
 */
- (void)setLayoutConstantWithValue:(NSValue *)value;

@end


@interface CBConstraint (Abstract)

/**
 *	Sets the constraint relation to given NSLayoutRelation
 *  returns a block which accepts one of the following:
 *    CBViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (CBConstraint * (^)(id, NSLayoutRelation))equalToWithRelation;

/**
 *	Override to set a custom chaining behaviour
 */
- (CBConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end


@protocol CBConstraintDelegate <NSObject>

/**
 *	Notifies the delegate when the constraint needs to be replaced with another constraint. For example
 *  A CBViewConstraint may turn into a CBCompositeConstraint when an array is passed to one of the equality blocks
 */
- (void)constraint:(CBConstraint *)constraint shouldBeReplacedWithConstraint:(CBConstraint *)replacementConstraint;

- (CBConstraint *)constraint:(CBConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end
