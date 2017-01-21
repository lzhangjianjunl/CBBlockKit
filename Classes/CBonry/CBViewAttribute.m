//
//  CBAttribute.m
//  CBonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "CBViewAttribute.h"

@implementation CBViewAttribute

- (id)initWithView:(CB_VIEW *)view layoutAttribute:(NSLayoutAttribute)layoutAttribute {
    self = [self initWithView:view item:view layoutAttribute:layoutAttribute];
    return self;
}

- (id)initWithView:(CB_VIEW *)view item:(id)item layoutAttribute:(NSLayoutAttribute)layoutAttribute {
    self = [super init];
    if (!self) return nil;
    
    _view = view;
    _item = item;
    _layoutAttribute = layoutAttribute;
    
    return self;
}

- (BOOL)isSizeAttribute {
    return self.layoutAttribute == NSLayoutAttributeWidth
        || self.layoutAttribute == NSLayoutAttributeHeight;
}

- (BOOL)isEqual:(CBViewAttribute *)viewAttribute {
    if ([viewAttribute isKindOfClass:self.class]) {
        return self.view == viewAttribute.view
            && self.layoutAttribute == viewAttribute.layoutAttribute;
    }
    return [super isEqual:viewAttribute];
}

- (NSUInteger)hash {
    return CB_NSUINTROTATE([self.view hash], CB_NSUINT_BIT / 2) ^ self.layoutAttribute;
}

@end
