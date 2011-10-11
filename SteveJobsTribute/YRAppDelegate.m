//
//  YRAppDelegate.m
//  SteveJobsTribute
//
//  Created by Jack Perry on 6/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "YRAppDelegate.h"
#import "YRCorkViewcontroller.h"
#import "YRTributeMessages.h"
#import "NSString+Additions.h"
#import "UINavigationBar+CustomImage.h"

@implementation YRAppDelegate

@synthesize window, navController;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    corkViewcontroller = [[YRCorkViewController alloc] init];
    
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:corkViewcontroller];
    UINavigationBar *navigationBar = navigationController.navigationBar;
    
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar-background"] withSize:navigationBar.bounds.size];
    self.navController = navigationController;
    
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
    
    
    /* Tribute Collector */
    YRTributeMessages *tributeMessages = [[YRTributeMessages alloc] init];
    [tributeMessages setDelegate:self];
    [tributeMessages tributeMessagesFromOffset:0 withRange:20];
    
    
    /* Analytics */
    /*NSString *APIKey = [[[[NSBundle mainBundle] bundleIdentifier] reverse] MD5EncryptString];
    YRAnalytics *analytics = [[YRAnalytics alloc] initWithAPIKey:APIKey];
    [analytics registerDeivceWithApplicationIdentifier:[[NSBundle mainBundle] bundleIdentifier]];*/
    
    
    return YES;
    
}







#pragma mark - Tribute Messages
- (void)didFinishLoadingTributes:(NSArray *)tributeObjects {
    
    [corkViewcontroller setTributeObjects:tributeObjects];
    [corkViewcontroller reloadData];
    
    
}














- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
