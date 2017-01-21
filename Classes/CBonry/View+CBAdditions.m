//
//  UIView+CBAdditions.m
//  CBonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "View+CBAdditions.h"
#import <objc/runtime.h>

@implementation CB_VIEW (CBAdditions)

- (NSArray *)CB_makeConstraints:(void(^)(CBConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    CBConstraintMaker *constraintMaker = [[CBConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)CB_updateConstraints:(void(^)(CBConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    CBConstraintMaker *constraintMaker = [[CBConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)CB_remakeConstraints:(void(^)(CBConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    CBConstraintMaker *constraintMaker = [[CBConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (CBViewAttribute *)CB_left {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (CBViewAttribute *)CB_top {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (CBViewAttribute *)CB_right {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (CBViewAttribute *)CB_bottom {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (CBViewAttribute *)CB_leading {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (CBViewAttribute *)CB_trailing {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (CBViewAttribute *)CB_width {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (CBViewAttribute *)CB_height {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (CBViewAttribute *)CB_centerX {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (CBViewAttribute *)CB_centerY {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (CBViewAttribute *)CB_baseline {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (CBViewAttribute *(^)(NSLayoutAttribute))CB_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[CBViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (CBViewAttribute *)CB_firstBaseline {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeFirstBaseline];
}
- (CBViewAttribute *)CB_lastBaseline {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (CBViewAttribute *)CB_leftMargin {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (CBViewAttribute *)CB_rightMargin {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (CBViewAttribute *)CB_topMargin {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (CBViewAttribute *)CB_bottomMargin {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (CBViewAttribute *)CB_leadingMargin {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (CBViewAttribute *)CB_trailingMargin {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (CBViewAttribute *)CB_centerXWithinMargins {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (CBViewAttribute *)CB_centerYWithinMargins {
    return [[CBViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif

#pragma mark - associated properties

- (id)CB_key {
    return objc_getAssociatedObject(self, @selector(CB_key));
}

- (void)setCB_key:(id)key {
    objc_setAssociatedObject(self, @selector(CB_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)CB_closestCommonSuperview:(CB_VIEW *)view {
    CB_VIEW *closestCommonSuperview = nil;

    CB_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        CB_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
