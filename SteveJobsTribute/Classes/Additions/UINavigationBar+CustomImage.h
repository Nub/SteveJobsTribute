//
//  UINaviagtionBar+BackgroundImage.h
//  Frequencies
//
//  Created by Jack Perry on 16/07/11.
//  Copyright 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (CustomImage)

- (void)setBackgroundImage:(UIImage *)image withSize:(CGSize)aSize;
- (void) setBackgroundImage:(UIImage*)image;
- (void) clearBackgroundImage;

@end

