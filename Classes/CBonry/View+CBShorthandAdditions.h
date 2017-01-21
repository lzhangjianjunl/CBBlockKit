//
//  UIView+CBShorthandAdditions.h
//  CBonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+CBAdditions.h"

#ifdef CB_SHORTHAND

/**
 *	Shorthand view additions without the 'CB_' prefixes,
 *  only enabled if CB_SHORTHAND is defined
 */
@interface CB_VIEW (CBShorthandAdditions)

@property (nonatomic, strong, readonly) CBViewAttribute *left;
@property (nonatomic, strong, readonly) CBViewAttribute *top;
@property (nonatomic, strong, readonly) CBViewAttribute *right;
@property (nonatomic, strong, readonly) CBViewAttribute *bottom;
@property (nonatomic, strong, readonly) CBViewAttribute *leading;
@property (nonatomic, strong, readonly) CBViewAttribute *trailing;
@property (nonatomic, strong, readonly) CBViewAttribute *width;
@property (nonatomic, strong, readonly) CBViewAttribute *height;
@property (nonatomic, strong, readonly) CBViewAttribute *centerX;
@property (nonatomic, strong, readonly) CBViewAttribute *centerY;
@property (nonatomic, strong, readonly) CBViewAttribute *baseline;
@property (nonatomic, strong, readonly) CBViewAttribute *(^attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) CBViewAttribute *firstBaseline;
@property (nonatomic, strong, readonly) CBViewAttribute *lastBaseline;

#endif

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) CBViewAttribute *leftMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *rightMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *topMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *bottomMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *leadingMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *trailingMargin;
@property (nonatomic, strong, readonly) CBViewAttribute *centerXWithinMargins;
@property (nonatomic, strong, readonly) CBViewAttribute *centerYWithinMargins;

#endif

- (NSArray *)makeConstraints:(void(^)(CBConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(CBConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(CBConstraintMaker *make))block;

@end

#define CB_ATTR_FORWARD(attr)  \
- (CBViewAttribute *)attr {    \
    return [self CB_##attr];   \
}

@implementation CB_VIEW (CBShorthandAdditions)

CB_ATTR_FORWARD(top);
CB_ATTR_FORWARD(left);
CB_ATTR_FORWARD(bottom);
CB_ATTR_FORWARD(right);
CB_ATTR_FORWARD(leading);
CB_ATTR_FORWARD(trailing);
CB_ATTR_FORWARD(width);
CB_ATTR_FORWARD(height);
CB_ATTR_FORWARD(centerX);
CB_ATTR_FORWARD(centerY);
CB_ATTR_FORWARD(baseline);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

CB_ATTR_FORWARD(firstBaseline);
CB_ATTR_FORWARD(lastBaseline);

#endif

#if TARGET_OS_IPHONE || TARGET_OS_TV

CB_ATTR_FORWARD(leftMargin);
CB_ATTR_FORWARD(rightMargin);
CB_ATTR_FORWARD(topMargin);
CB_ATTR_FORWARD(bottomMargin);
CB_ATTR_FORWARD(leadingMargin);
CB_ATTR_FORWARD(trailingMargin);
CB_ATTR_FORWARD(centerXWithinMargins);
CB_ATTR_FORWARD(centerYWithinMargins);

#endif

- (CBViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self CB_attribute];
}

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
