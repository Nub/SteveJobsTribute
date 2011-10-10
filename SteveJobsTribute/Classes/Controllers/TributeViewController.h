//
//  TributeViewController.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YRTribute.h"

@interface TributeViewController : UIViewController{
    
    YRTribute *tribute;
    
}

@property (nonatomic, retain) YRTribute *tribute;

@end
