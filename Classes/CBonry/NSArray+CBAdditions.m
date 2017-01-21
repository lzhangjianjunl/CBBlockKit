//
//  NSArray+CBAdditions.m
//  
//
//  Created by Daniel Hammond on 11/26/13.
//
//

#import "NSArray+CBAdditions.h"
#import "View+CBAdditions.h"

@implementation NSArray (CBAdditions)

- (NSArray *)CB_makeConstraints:(void(^)(CBConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (CB_VIEW *view in self) {
        NSAssert([view isKindOfClass:[CB_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view CB_makeConstraints:block]];
    }
    return constraints;
}

- (NSArray *)CB_updateConstraints:(void(^)(CBConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (CB_VIEW *view in self) {
        NSAssert([view isKindOfClass:[CB_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view CB_updateConstraints:block]];
    }
    return constraints;
}

- (NSArray *)CB_remakeConstraints:(void(^)(CBConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (CB_VIEW *view in self) {
        NSAssert([view isKindOfClass:[CB_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view CB_remakeConstraints:block]];
    }
    return constraints;
}

- (void)CB_distributeViewsAlongAxis:(CBAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    CB_VIEW *tempSuperView = [self CB_commonSuperviewOfViews];
    if (axisType == CBAxisTypeHorizontal) {
        CB_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            CB_VIEW *v = self[i];
            [v CB_makeConstraints:^(CBConstraintMaker *make) {
                if (prev) {
                    make.width.equalTo(prev);
                    make.left.equalTo(prev.CB_right).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
    else {
        CB_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            CB_VIEW *v = self[i];
            [v CB_makeConstraints:^(CBConstraintMaker *make) {
                if (prev) {
                    make.height.equalTo(prev);
                    make.top.equalTo(prev.CB_bottom).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }                    
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
}

- (void)CB_distributeViewsAlongAxis:(CBAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    CB_VIEW *tempSuperView = [self CB_commonSuperviewOfViews];
    if (axisType == CBAxisTypeHorizontal) {
        CB_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            CB_VIEW *v = self[i];
            [v CB_makeConstraints:^(CBConstraintMaker *make) {
                if (prev) {
                    CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                    make.width.equalTo(@(fixedItemLength));
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        make.right.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                    make.width.equalTo(@(fixedItemLength));
                }
            }];
            prev = v;
        }
    }
    else {
        CB_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            CB_VIEW *v = self[i];
            [v CB_makeConstraints:^(CBConstraintMaker *make) {
                if (prev) {
                    CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                    make.height.equalTo(@(fixedItemLength));
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        make.bottom.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                    make.height.equalTo(@(fixedItemLength));
                }
            }];
            prev = v;
        }
    }
}

- (CB_VIEW *)CB_commonSuperviewOfViews
{
    CB_VIEW *commonSuperview = nil;
    CB_VIEW *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[CB_VIEW class]]) {
            CB_VIEW *view = (CB_VIEW *)object;
            if (previousView) {
                commonSuperview = [view CB_closestCommonSuperview:commonSuperview];
            } else {
                commonSuperview = view;
            }
            previousView = view;
        }
    }
    NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
    return commonSuperview;
}

@end
