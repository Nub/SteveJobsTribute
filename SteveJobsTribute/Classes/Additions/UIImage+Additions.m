//
//  UIImage+Additions.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/11/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Sizing)

- (UIImage*)imageFittingToRect:(CGRect)aRect maintainAspect:(BOOL)maintainAspect{
    
    CGFloat w = aRect.size.width;
    CGFloat h = aRect.size.height;
    
    if (maintainAspect) {
        if (w > h) {
            h *= w/self.size.width;//scale maintaining aspect
        }else if(h > w){
            w *= h/self.size.height;//scale maintaining aspect
        }
    }
    
    CGRect drawRect = CGRectMake(0, 0, w, h);
    
    UIGraphicsBeginImageContext(drawRect.size);
    
    [self drawInRect:drawRect];
    
    return UIGraphicsGetImageFromCurrentImageContext();
    
}

@end
