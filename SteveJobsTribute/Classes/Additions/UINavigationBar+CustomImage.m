//
//  UINaviagtionBar+BackgroundImage.m
//  Frequencies
//
//  Created by Jack Perry on 16/07/11.
//  Copyright 2011 Yoshimi Robotics. All rights reserved.
//

#import "UINavigationBar+CustomImage.h"

@implementation UINavigationBar (CustomImage)

- (void) setBackgroundImage:(UIImage*)image {
    if (image == NULL) return;
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    } else {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, 320, 44);
        [self insertSubview:imageView atIndex:0];
    }
}

- (void) clearBackgroundImage {
    NSArray *subviews = [self subviews];
    for (int i=0; i<[subviews count]; i++) {
        if ([[subviews objectAtIndex:i]  isMemberOfClass:[UIImageView class]]) {
            [[subviews objectAtIndex:i] removeFromSuperview];
        }
    }    
}

@end

