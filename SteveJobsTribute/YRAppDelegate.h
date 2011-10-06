//
//  YRAppDelegate.h
//  SteveJobsTribute
//
//  Created by Jack Perry on 6/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRAppDelegate : UIResponder <UIApplicationDelegate> {
    
    UIWindow                *window;
    UINavigationController  *navController;
    
}


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;



@end
