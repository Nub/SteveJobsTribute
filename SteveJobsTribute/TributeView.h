//
//  TributeView.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTribute.h"

@interface TributeView : UIView{
    
    NSString *title;
    NSString *author;
    NSString *message;
    NSURL *image;
    
    YRTribute *tribute;
    
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSURL *image;

@property (nonatomic, retain) YRTribute *tribute;

@end
