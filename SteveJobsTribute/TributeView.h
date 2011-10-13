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
    UIImageView *imageView;

    
    YRTribute *tribute;
    
}

@property (nonatomic, retain)   UIImageView *imageView;

@property (nonatomic, retain) YRTribute *tribute;

+ (TributeView*)tributeViewFromTribute:(YRTribute*)tribute;

@end
