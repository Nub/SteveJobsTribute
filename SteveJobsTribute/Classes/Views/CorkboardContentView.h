//
//  CorkboardContentView.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/6/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

@protocol CorkboardPostDelegate

- (void)tappedPostAtIndex:(NSInteger)index;

@end

@interface CorkboardContentView : UIView{
    UIDeviceOrientation layoutOrientation;
    id <CorkboardPostDelegate> delegate;
}

@property (nonatomic) UIDeviceOrientation layoutOrientation;
@property (nonatomic, retain) id <CorkboardPostDelegate> delegate;

//Add a post representation
- (void)addPost:(NSString *)title;

//Add a count of post representations
- (void)addPosts:(NSArray*)titles;

- (CGRect)postRect:(NSInteger)postIndex;
- (CATransform3D)postTransform:(NSInteger)postIndex;
- (void)hidePost:(NSInteger)postIndex;
- (void)showPost:(NSInteger)postIndex;

@end
