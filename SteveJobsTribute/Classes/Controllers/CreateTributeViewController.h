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
#import "YRSubmitTribute.h"

@interface CreateTributeViewController : UIViewController <YRSubmitTributeDelegate> {    
    
    BOOL presenting;
    
}

@property (nonatomic, getter = isPresenting) BOOL presenting;

- (void)presentViewFromRect:(CGRect)fromRect inView:(UIView*)aView;

- (void)hideViewToRect:(CGRect)toRect;

@end
