//
//  TributeViewController.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "TributeViewController.h"
#import "TributeView.h"
#import "SVProgressHUD.h"

#define kAnimationTime 0.5

@interface TributeViewController (){
    @private
    CGRect presentRect;
    
}

- (void)flagTribute:(UIButton *)sender;
- (void)closeTribute:(UIButton *)sender;

@end

@implementation TributeViewController

@synthesize presenting, delegate;

- (void)loadView{
    
    self.view = [[TributeView alloc] initWithFrame:CGRectMake(0, 0, 480, 640)];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake(15, 15, 64, 32)];

    UIImage *closeButtonImage = [UIImage imageNamed:@"tribute-close"];
    [closeButton setBackgroundImage:closeButtonImage forState:UIControlStateNormal];
    
    [closeButton addTarget:self action:@selector(closeTribute:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:closeButton];
    
    
    
    UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flagButton setFrame:CGRectMake(443, 22, 17, 20)];
    
    UIImage *flagButtonImage = [UIImage imageNamed:@"flag"];
    [flagButton setBackgroundImage:flagButtonImage forState:UIControlStateNormal];
    
    [flagButton addTarget:self action:@selector(flagTribute:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:flagButton];
    

    
    
    presenting = NO;
    
}

- (void)setTribute:(YRTribute *)tribute {
    
    aTribute = tribute;
    
    TributeView *tributeView = (id)self.view;
    [tributeView setTribute:aTribute];
    
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
    
    TributeView *tributeView = (id)self.view;
    
    [imageView removeFromSuperview];
    
    [UIView animateWithDuration:kAnimationTime animations:^(void){
        
        self.view.frame = toRect;
        self.view.alpha = 0;
        tributeView.image
        
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

- (void)closeTribute:(UIButton *)sender{
    
    [self setPresenting:NO];
    
    [delegate didCloseTribute];
    
}

- (void)flagTribute:(UIButton *)sender {
    
    YRReportMessage *reportMessage = [[YRReportMessage alloc] init];
    [reportMessage setDelegate:self];
    [reportMessage reportTribute:aTribute];
    
    [SVProgressHUD showInView:self.view status:@"Please wait.." networkIndicator:YES];
    
}

- (void)didFinishReportingTribute {
    
    [SVProgressHUD dismissWithSuccess:@"Completed!"];
    
}

- (void)didFailToReportTribute:(NSError *)error {
    
    [SVProgressHUD dismissWithError:[error localizedDescription]];
    
}


@end
