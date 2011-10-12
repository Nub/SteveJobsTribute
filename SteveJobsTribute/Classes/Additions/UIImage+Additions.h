//
//  UIImage+Additions.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/11/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Sizing)

//- (UIImage*)imageFittingToRect:(CGRect)aRect;
- (UIImage*)imageFittingToRect:(CGRect)aRect maintainAspect:(BOOL)maintainAspect;

@end
