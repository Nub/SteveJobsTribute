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

@protocol TributeViewControllerDelegate

- (void)didCloseTribute;

@end

@interface TributeViewController : UIViewController{
    
    BOOL presenting;
    
    id <TributeViewControllerDelegate> delegate;
}

@property (nonatomic, getter = isPresenting) BOOL presenting;

@property (nonatomic, retain) id <TributeViewControllerDelegate> delegate;

- (void)setTribute:(YRTribute*)tribute;

- (void)presentViewFromRect:(CGRect)fromRect inView:(UIView*)aView;

- (void)hideViewToRect:(CGRect)toRect;

@end
