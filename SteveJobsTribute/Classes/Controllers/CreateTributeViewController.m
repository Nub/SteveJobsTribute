//
//  CreateTributeViewController.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "CreateTributeViewController.h"

#define kAnimationTime 0.5

@interface CreateTributeViewController ()
{
    @private
    CGRect presentRect;
    
}


@end

@implementation CreateTributeViewController

@synthesize delegate;
@synthesize presenting;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    
    self.view = [[CreateTributeView alloc] initWithFrame:CGRectMake(0, 0, 640, 480)];
    
}

- (void)presentViewFromRect:(CGRect)fromRect inView:(UIView*)aView{
    
    presentRect = fromRect;
    
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
    
    [UIView animateWithDuration:kAnimationTime animations:^(void){
        
        self.view.alpha = 1;
        self.view.frame = newFrame;
        
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

- (void)setPresenting:(BOOL)newPresenting{
    
    if (presenting && !newPresenting) {
        
        [self hideViewToRect:presentRect];
        
    }
    
}

#pragma mark - Private Helpers

- (void)cancelTribute:(UIButton *)sender{
    
    [self setPresenting:NO];
    
    [delegate didCancelCreateTribute];
    
}
@end
