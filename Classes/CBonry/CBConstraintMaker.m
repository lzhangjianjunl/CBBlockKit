//
//  CBConstraintBuilder.m
//  CBonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "CBConstraintMaker.h"
#import "CBViewConstraint.h"
#import "CBCompositeConstraint.h"
#import "CBConstraint+Private.h"
#import "CBViewAttribute.h"
#import "View+CBAdditions.h"

@interface CBConstraintMaker () <CBConstraintDelegate>

@property (nonatomic, weak) CB_VIEW *view;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

@implementation CBConstraintMaker

- (id)initWithView:(CB_VIEW *)view {
    self = [super init];
    if (!self) return nil;
    
    self.view = view;
    self.constraints = NSMutableArray.new;
    
    return self;
}

- (NSArray *)install {
    if (self.removeExisting) {
        NSArray *installedConstraints = [CBViewConstraint installedConstraintsForView:self.view];
        for (CBConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }
    NSArray *constraints = self.constraints.copy;
    for (CBConstraint *constraint in constraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
    [self.constraints removeAllObjects];
    return constraints;
}

#pragma mark - CBConstraintDelegate

- (void)constraint:(CBConstraint *)constraint shouldBeReplacedWithConstraint:(CBConstraint *)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (CBConstraint *)constraint:(CBConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    CBViewAttribute *viewAttribute = [[CBViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    CBViewConstraint *newConstraint = [[CBViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    if ([constraint isKindOfClass:CBViewConstraint.class]) {
        //replace with composite constraint
        NSArray *children = @[constraint, newConstraint];
        CBCompositeConstraint *compositeConstraint = [[CBCompositeConstraint alloc] initWithChildren:children];
        compositeConstraint.delegate = self;
        [self constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
        return compositeConstraint;
    }
    if (!constraint) {
        newConstraint.delegate = self;
        [self.constraints addObject:newConstraint];
    }
    return newConstraint;
}

- (CBConstraint *)addConstraintWithAttributes:(CBAttribute)attrs {
    __unused CBAttribute anyAttribute = (CBAttributeLeft | CBAttributeRight | CBAttributeTop | CBAttributeBottom | CBAttributeLeading
                                          | CBAttributeTrailing | CBAttributeWidth | CBAttributeHeight | CBAttributeCenterX
                                          | CBAttributeCenterY | CBAttributeBaseline
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
                                          | CBAttributeFirstBaseline | CBAttributeLastBaseline
#endif
#if TARGET_OS_IPHONE || TARGET_OS_TV
                                          | CBAttributeLeftMargin | CBAttributeRightMargin | CBAttributeTopMargin | CBAttributeBottomMargin
                                          | CBAttributeLeadingMargin | CBAttributeTrailingMargin | CBAttributeCenterXWithinMargins
                                          | CBAttributeCenterYWithinMargins
#endif
                                          );
    
    NSAssert((attrs & anyAttribute) != 0, @"You didn't pass any attribute to make.attributes(...)");
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & CBAttributeLeft) [attributes addObject:self.view.CB_left];
    if (attrs & CBAttributeRight) [attributes addObject:self.view.CB_right];
    if (attrs & CBAttributeTop) [attributes addObject:self.view.CB_top];
    if (attrs & CBAttributeBottom) [attributes addObject:self.view.CB_bottom];
    if (attrs & CBAttributeLeading) [attributes addObject:self.view.CB_leading];
    if (attrs & CBAttributeTrailing) [attributes addObject:self.view.CB_trailing];
    if (attrs & CBAttributeWidth) [attributes addObject:self.view.CB_width];
    if (attrs & CBAttributeHeight) [attributes addObject:self.view.CB_height];
    if (attrs & CBAttributeCenterX) [attributes addObject:self.view.CB_centerX];
    if (attrs & CBAttributeCenterY) [attributes addObject:self.view.CB_centerY];
    if (attrs & CBAttributeBaseline) [attributes addObject:self.view.CB_baseline];
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    if (attrs & CBAttributeFirstBaseline) [attributes addObject:self.view.CB_firstBaseline];
    if (attrs & CBAttributeLastBaseline) [attributes addObject:self.view.CB_lastBaseline];
    
#endif
    
#if TARGET_OS_IPHONE || TARGET_OS_TV
    
    if (attrs & CBAttributeLeftMargin) [attributes addObject:self.view.CB_leftMargin];
    if (attrs & CBAttributeRightMargin) [attributes addObject:self.view.CB_rightMargin];
    if (attrs & CBAttributeTopMargin) [attributes addObject:self.view.CB_topMargin];
    if (attrs & CBAttributeBottomMargin) [attributes addObject:self.view.CB_bottomMargin];
    if (attrs & CBAttributeLeadingMargin) [attributes addObject:self.view.CB_leadingMargin];
    if (attrs & CBAttributeTrailingMargin) [attributes addObject:self.view.CB_trailingMargin];
    if (attrs & CBAttributeCenterXWithinMargins) [attributes addObject:self.view.CB_centerXWithinMargins];
    if (attrs & CBAttributeCenterYWithinMargins) [attributes addObject:self.view.CB_centerYWithinMargins];
    
#endif
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (CBViewAttribute *a in attributes) {
        [children addObject:[[CBViewConstraint alloc] initWithFirstViewAttribute:a]];
    }
    
    CBCompositeConstraint *constraint = [[CBCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

#pragma mark - standard Attributes

- (CBConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    return [self constraint:nil addConstraintWithLayoutAttribute:layoutAttribute];
}

- (CBConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (CBConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (CBConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (CBConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (CBConstraint *)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (CBConstraint *)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (CBConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (CBConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (CBConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (CBConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (CBConstraint *)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}

- (CBConstraint *(^)(CBAttribute))attributes {
    return ^(CBAttribute attrs){
        return [self addConstraintWithAttributes:attrs];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (CBConstraint *)firstBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeFirstBaseline];
}

- (CBConstraint *)lastBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif


#if TARGET_OS_IPHONE || TARGET_OS_TV

- (CBConstraint *)leftMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeftMargin];
}

- (CBConstraint *)rightMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRightMargin];
}

- (CBConstraint *)topMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTopMargin];
}

- (CBConstraint *)bottomMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottomMargin];
}

- (CBConstraint *)leadingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (CBConstraint *)trailingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (CBConstraint *)centerXWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (CBConstraint *)centerYWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif


#pragma mark - composite Attributes

- (CBConstraint *)edges {
    return [self addConstraintWithAttributes:CBAttributeTop | CBAttributeLeft | CBAttributeRight | CBAttributeBottom];
}

- (CBConstraint *)size {
    return [self addConstraintWithAttributes:CBAttributeWidth | CBAttributeHeight];
}

- (CBConstraint *)center {
    return [self addConstraintWithAttributes:CBAttributeCenterX | CBAttributeCenterY];
}

#pragma mark - grouping

- (CBConstraint *(^)(dispatch_block_t group))group {
    return ^id(dispatch_block_t group) {
        NSInteger previousCount = self.constraints.count;
        group();

        NSArray *children = [self.constraints subarrayWithRange:NSMakeRange(previousCount, self.constraints.count - previousCount)];
        CBCompositeConstraint *constraint = [[CBCompositeConstraint alloc] initWithChildren:children];
        constraint.delegate = self;
        return constraint;
    };
}

@end
