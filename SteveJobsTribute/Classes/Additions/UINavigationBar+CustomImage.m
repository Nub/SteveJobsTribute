//
//  UINaviagtionBar+BackgroundImage.m
//  Frequencies
//
//  Created by Jack Perry on 16/07/11.
//  Copyright 2011 Yoshimi Robotics. All rights reserved.
//

#import "UINavigationBar+CustomImage.h"

@implementation UINavigationBar (CustomImage)

- (void)setBackgroundImage:(UIImage*)image {
    if (image == NULL) return;
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    } else {
       /* UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = self.frame;
        [self insertSubview:imageView atIndex:0];*/
        
        UIColor *backgroundColor = [UIColor colorWithPatternImage:image];
        self.backgroundColor = backgroundColor;
        
    }
}


- (void)setBackgroundImage:(UIImage *)image withSize:(CGSize)aSize {
    
    if (image == nil) return;
    
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    else {
        
       /* UIGraphicsBeginImageContext(aSize);
        
        CGRect aRect = CGRectMake(0, 0, aSize.width, 48);
        [image drawAsPatternInRect:aRect];
        
        UIImage *backgroundPattern = UIGraphicsGetImageFromCurrentImageContext();
        
        
        UIImageView *background = [[UIImageView alloc] initWithImage:backgroundPattern];
        background.frame = aRect;
        [self insertSubview:background atIndex:0];*/
        
        
        
        
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

