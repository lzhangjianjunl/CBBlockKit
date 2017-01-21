//
//  UIViewController+CBAdditions.h
//  CBonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "CBUtilities.h"
#import "CBConstraintMaker.h"
#import "CBViewAttribute.h"

#ifdef CB_VIEW_CONTROLLER

@interface CB_VIEW_CONTROLLER (CBAdditions)

/**
 *	following properties return a new CBViewAttribute with appropriate UILayoutGuide and NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) CBViewAttribute *cb_topLayoutGuide;
@property (nonatomic, strong, readonly) CBViewAttribute *cb_bottomLayoutGuide;
@property (nonatomic, strong, readonly) CBViewAttribute *cb_topLayoutGuideTop;
@property (nonatomic, strong, readonly) CBViewAttribute *cb_topLayoutGuideBottom;
@property (nonatomic, strong, readonly) CBViewAttribute *cb_bottomLayoutGuideTop;
@property (nonatomic, strong, readonly) CBViewAttribute *cb_bottomLayoutGuideBottom;


@end

#endif
