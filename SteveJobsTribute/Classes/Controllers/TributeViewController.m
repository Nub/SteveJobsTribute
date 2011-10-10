//
//  TributeViewController.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "TributeViewController.h"
#import "TributeView.h"

#define kAnimationTime 0.5

@implementation TributeViewController

@synthesize presenting;

- (void)loadView{
    
    self.view = [[TributeView alloc] initWithFrame:CGRectMake(0, 0, 480, 640)];
    presenting = NO;
    
}

- (void)setTribute:(YRTribute*)tribute{
    
    TributeView *tributeView = (id)self.view;
    [tributeView setTribute:tribute];
    
}

- (void)presentViewFromRect:(CGRect)fromRect withTransform:(CATransform3D)transform inView:(UIView*)aView{
                    
    [aView addSubview:self.view];
    [aView bringSubviewToFront:self.view];
    
    CGRect newFrame = self.view.frame;
    newFrame.size.width = 480;
    newFrame.size.height = 640;

    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if (UIDeviceOrientationIsLandscape(orientation)){
        
        newFrame.origin.x = 272;
        newFrame.origin.y = 40;
        
    }else{
        
        newFrame.origin.x = 144;
        newFrame.origin.y = 192;
        
    }

    self.view.frame = fromRect;
    self.view.alpha = 0;
    self.view.layer.transform = transform;

    [UIView animateWithDuration:kAnimationTime animations:^(void){
        
        self.view.alpha = 1;
        self.view.frame = newFrame;
        self.view.layer.transform = CATransform3DIdentity;
        
    } completion:^(BOOL finished){
        
        presenting = YES;
        
    }];
    
}

- (void)hideViewToRect:(CGRect)toRect{
    
    [UIView animateWithDuration:kAnimationTime animations:^(void){
        
        self.view.frame = toRect;
        self.view.alpha = 0;
        
    } completion:^(BOOL finished){
        
        [self.view removeFromSuperview];

        presenting = NO;
        
    }];
    
}

@end
