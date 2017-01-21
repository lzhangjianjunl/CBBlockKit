//
//  CBConstraint.h
//  CBonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "CBUtilities.h"

/**
 *	Enables Constraints to be created with chainable syntax
 *  Constraint can represent single NSLayoutConstraint (CBViewConstraint) 
 *  or a group of NSLayoutConstraints (CBComposisteConstraint)
 */
@interface CBConstraint : NSObject

// Chaining Support

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects CBConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (CBConstraint * (^)(CBEdgeInsets insets))insets;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects CBConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeWidth, NSLayoutAttributeHeight
 */
- (CBConstraint * (^)(CGSize offset))sizeOffset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects CBConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeCenterX, NSLayoutAttributeCenterY
 */
- (CBConstraint * (^)(CGPoint offset))centerOffset;

/**
 *	Modifies the NSLayoutConstraint constant
 */
- (CBConstraint * (^)(CGFloat offset))offset;

/**
 *  Modifies the NSLayoutConstraint constant based on a value type
 */
- (CBConstraint * (^)(NSValue *value))valueOffset;

/**
 *	Sets the NSLayoutConstraint multiplier property
 */
- (CBConstraint * (^)(CGFloat multiplier))multipliedBy;

/**
 *	Sets the NSLayoutConstraint multiplier to 1.0/dividedBy
 */
- (CBConstraint * (^)(CGFloat divider))dividedBy;

/**
 *	Sets the NSLayoutConstraint priority to a float or CBLayoutPriority
 */
- (CBConstraint * (^)(CBLayoutPriority priority))priority;

/**
 *	Sets the NSLayoutConstraint priority to CBLayoutPriorityLow
 */
- (CBConstraint * (^)())priorityLow;

/**
 *	Sets the NSLayoutConstraint priority to CBLayoutPriorityMedium
 */
- (CBConstraint * (^)())priorityMedium;

/**
 *	Sets the NSLayoutConstraint priority to CBLayoutPriorityHigh
 */
- (CBConstraint * (^)())priorityHigh;

/**
 *	Sets the constraint relation to NSLayoutRelationEqual
 *  returns a block which accepts one of the following:
 *    CBViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (CBConstraint * (^)(id attr))equalTo;

/**
 *	Sets the constraint relation to NSLayoutRelationGreaterThanOrEqual
 *  returns a block which accepts one of the following:
 *    CBViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (CBConstraint * (^)(id attr))greaterThanOrEqualTo;

/**
 *	Sets the constraint relation to NSLayoutRelationLessThanOrEqual
 *  returns a block which accepts one of the following:
 *    CBViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (CBConstraint * (^)(id attr))lessThanOrEqualTo;

/**
 *	Optional semantic property which has no effect but improves the readability of constraint
 */
- (CBConstraint *)with;

/**
 *	Optional semantic property which has no effect but improves the readability of constraint
 */
- (CBConstraint *)and;

/**
 *	Creates a new CBCompositeConstraint with the called attribute and reciever
 */
- (CBConstraint *)left;
- (CBConstraint *)top;
- (CBConstraint *)right;
- (CBConstraint *)bottom;
- (CBConstraint *)leading;
- (CBConstraint *)trailing;
- (CBConstraint *)width;
- (CBConstraint *)height;
- (CBConstraint *)centerX;
- (CBConstraint *)centerY;
- (CBConstraint *)baseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (CBConstraint *)firstBaseline;
- (CBConstraint *)lastBaseline;

#endif

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (CBConstraint *)leftMargin;
- (CBConstraint *)rightMargin;
- (CBConstraint *)topMargin;
- (CBConstraint *)bottomMargin;
- (CBConstraint *)leadingMargin;
- (CBConstraint *)trailingMargin;
- (CBConstraint *)centerXWithinMargins;
- (CBConstraint *)centerYWithinMargins;

#endif


/**
 *	Sets the constraint debug name
 */
- (CBConstraint * (^)(id key))key;

// NSLayoutConstraint constant Setters
// for use outside of CB_updateConstraints/CB_makeConstraints blocks

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects CBConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (void)setInsets:(CBEdgeInsets)insets;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects CBConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeWidth, NSLayoutAttributeHeight
 */
- (void)setSizeOffset:(CGSize)sizeOffset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects CBConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeCenterX, NSLayoutAttributeCenterY
 */
- (void)setCenterOffset:(CGPoint)centerOffset;

/**
 *	Modifies the NSLayoutConstraint constant
 */
- (void)setOffset:(CGFloat)offset;


// NSLayoutConstraint Installation support

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)
/**
 *  Whether or not to go through the animator proxy when modifying the constraint
 */
@property (nonatomic, copy, readonly) CBConstraint *animator;
#endif

/**
 *  Activates an NSLayoutConstraint if it's supported by an OS. 
 *  Invokes install otherwise.
 */
- (void)activate;

/**
 *  Deactivates previously installed/activated NSLayoutConstraint.
 */
- (void)deactivate;

/**
 *	Creates a NSLayoutConstraint and adds it to the appropriate view.
 */
- (void)install;

/**
 *	Removes previously installed NSLayoutConstraint
 */
- (void)uninstall;

@end


/**
 *  Convenience auto-boxing macros for CBConstraint methods.
 *
 *  Defining CB_SHORTHAND_GLOBALS will turn on auto-boxing for default syntax.
 *  A potential drawback of this is that the unprefixed macros will appear in global scope.
 */
#define cb_equalTo(...)                 equalTo(CBBoxValue((__VA_ARGS__)))
#define cb_greaterThanOrEqualTo(...)    greaterThanOrEqualTo(CBBoxValue((__VA_ARGS__)))
#define cb_lessThanOrEqualTo(...)       lessThanOrEqualTo(CBBoxValue((__VA_ARGS__)))

#define cb_offset(...)                  valueOffset(CBBoxValue((__VA_ARGS__)))


#ifdef CB_SHORTHAND_GLOBALS

#define equalTo(...)                     cb_equalTo(__VA_ARGS__)
#define greaterThanOrEqualTo(...)        cb_greaterThanOrEqualTo(__VA_ARGS__)
#define lessThanOrEqualTo(...)           cb_lessThanOrEqualTo(__VA_ARGS__)

#define offset(...)                      cb_offset(__VA_ARGS__)

#endif


@interface CBConstraint (AutoboxingSupport)

/**
 *  Aliases to corresponding relation methods (for shorthand macros)
 *  Also needed to aid autocompletion
 */
- (CBConstraint * (^)(id attr))cb_equalTo;
- (CBConstraint * (^)(id attr))cb_greaterThanOrEqualTo;
- (CBConstraint * (^)(id attr))cb_lessThanOrEqualTo;

/**
 *  A dummy method to aid autocompletion
 */
- (CBConstraint * (^)(id offset))cb_offset;

@end
