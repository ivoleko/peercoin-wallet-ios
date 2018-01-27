//
//  UIView+ILcategory.h
//  Feeda Social Messenger
//
//  Created by Ivo Leko on 11/11/14.
//  Copyright (c) 2014 Profico. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ILcategory)

- (void) removeAllSubviews;
- (void) roundMask: (CGFloat) pixels;
- (void) circleMask;
- (void) allignFramesOfAllSubviews;
- (CGPoint) centerOfView;
- (void) halfWidth;
- (void) halfHeight;
- (UIImage *)pb_takeSnapshotAfterScreenUpdates: (BOOL) updates;
@end
