//
//  YRAppDelegate.h
//  SteveJobsTribute
//
//  Created by Jack Perry on 6/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTributeMessages.h"

@class YRCorkViewController;

@interface YRAppDelegate : UIResponder <UIApplicationDelegate, YRTributeMessagesManager> {
    
    UIWindow                *window;
    UINavigationController  *navController;
    
    YRCorkViewController    *corkViewcontroller;
    
}


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;


@end
