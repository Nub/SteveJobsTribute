//
//  CreateTributeViewController.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateTributeView.h"
#import "YRTribute.h"

@protocol CreateTributeViewControllerDelegate

- (void)didCancelCreateTribute;
- (void)didSendTribute:(YRTribute*)tribute;

@end

@interface CreateTributeViewController : UIViewController
{
    id <CreateTributeViewControllerDelegate> delegate;
    
    BOOL presenting;
}

@property (nonatomic, retain) id <CreateTributeViewControllerDelegate> delegate;
@property (nonatomic, getter = isPresenting) BOOL presenting;

- (void)presentViewFromRect:(CGRect)fromRect inView:(UIView*)aView;

- (void)hideViewToRect:(CGRect)toRect;

@end
