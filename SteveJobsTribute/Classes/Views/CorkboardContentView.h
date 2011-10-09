//
//  CorkboardContentView.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/6/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CorkboardContentView : UIView{
    UIDeviceOrientation layoutOrientation;
}

@property (nonatomic) UIDeviceOrientation layoutOrientation;

//Add a post representation
- (void)addPost:(NSString *)title;

//Add a count of post representations
- (void)addPosts:(NSArray*)titles;

- (UIView *)focusPost:(NSInteger)postIndex completion:(void (^)(BOOL finished))completionBlock;

@end
