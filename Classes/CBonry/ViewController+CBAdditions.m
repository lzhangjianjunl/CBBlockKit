//
//  UIViewController+CBAdditions.m
//  CBonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "ViewController+CBAdditions.h"

#ifdef CB_VIEW_CONTROLLER

@implementation CB_VIEW_CONTROLLER (CBAdditions)

- (CBViewAttribute *)cb_topLayoutGuide {
    return [[CBViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (CBViewAttribute *)cb_topLayoutGuideTop {
    return [[CBViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (CBViewAttribute *)cb_topLayoutGuideBottom {
    return [[CBViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (CBViewAttribute *)cb_bottomLayoutGuide {
    return [[CBViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (CBViewAttribute *)cb_bottomLayoutGuideTop {
    return [[CBViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (CBViewAttribute *)cb_bottomLayoutGuideBottom {
    return [[CBViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}



@end

#endif
