//
//  YRCorkViewcontroller.h
//  SteveJobsTribute
//
//  Created by Jack Perry on 6/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CorkboardContentView.h"
#import "TributeViewController.h"
#import "CreateTributeViewController.h"


@interface YRCorkViewController : UIViewController <CorkboardPostDelegate, TributeViewControllerDelegate, CreateTributeViewControllerDelegate> {
    
    NSArray         *tributeObjects;
    
}


- (void)reloadData;
- (void)addPost:(YRTribute *)tribute;


@property (nonatomic, retain) NSArray *tributeObjects;


@end
