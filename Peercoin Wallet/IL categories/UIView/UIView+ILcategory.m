//
//  UIView+ILcategory.m
//  Feeda Social Messenger
//
//  Created by Ivo Leko on 11/11/14.
//  Copyright (c) 2014 Profico. All rights reserved.
//

#import "UIView+ILcategory.h"

@implementation UIView (ILcategory)

- (void) removeAllSubviews {
    NSMutableArray *arrayM = [NSMutableArray array];
    for (UIView *v in self.subviews) {
        [arrayM addObject:v];
    }
    
    for (UIView *v in arrayM) {
        [v removeFromSuperview];
    }
}

- (void) allignFramesOfAllSubviews {
    for (UIView *view in self.subviews) {
        view.frame = self.bounds;
    }
}

- (void) roundMask: (CGFloat) pixels {
    
    if (pixels == 0) {
        self.layer.cornerRadius = 0;
        self.layer.masksToBounds = NO;
    }
    else {
        self.layer.cornerRadius = pixels;
        self.layer.masksToBounds = YES;
    }
}

- (void) circleMask {
    [self roundMask:self.bounds.size.width/2.0];
}

- (CGPoint) centerOfView {
    return CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
}

- (void) halfWidth {
    CGRect rect = self.frame;
    rect.size.width /=2.0;
    self.frame = rect;
}
- (void) halfHeight {
    CGRect rect = self.frame;
    rect.size.height /=2.0;
    self.frame = rect;
}

- (UIImage *)pb_takeSnapshotAfterScreenUpdates: (BOOL) updates {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:updates];
    
    // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
