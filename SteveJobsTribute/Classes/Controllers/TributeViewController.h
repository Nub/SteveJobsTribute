//
//  TributeViewController.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


#import "YRTribute.h"

@interface TributeViewController : UIViewController{
    
    BOOL presenting;
}

@property (nonatomic, getter = isPresenting) BOOL presenting;

- (void)setTribute:(YRTribute*)tribute;

- (void)presentViewFromRect:(CGRect)fromRect withTransform:(CATransform3D)transform inView:(UIView*)aView;

- (void)hideViewToRect:(CGRect)toRect;

@end
