//
//  PostsContentView.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/6/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsContentView : UIView


//Add a post representation
- (void)addPost;

//Add a count of post representations
- (void)addPosts:(NSInteger)count;

@end
