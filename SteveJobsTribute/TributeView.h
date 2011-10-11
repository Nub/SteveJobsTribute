//
//  TributeView.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YRTribute.h"
#import "YRImageDownloader.h"

@interface TributeView : UIView <YRImageDownloaderDelegate> {
    
    NSString *title;
    NSString *author;
    NSString *message;
    UIImage *image;
    
    YRTribute *tribute;
    
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) UIImage  *image;

@property (nonatomic, retain) YRTribute *tribute;

@end
