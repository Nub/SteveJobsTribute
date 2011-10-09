//
//  TributeView.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TributeView : UIView{
    
    NSString *title;
    NSString *author;
    NSString *tribute;
    NSURL *image;
    
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *tribute;
@property (nonatomic, retain) NSURL *image;

@end
