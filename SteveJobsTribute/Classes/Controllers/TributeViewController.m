//
//  TributeViewController.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "TributeViewController.h"
#import "SVProgressHUD.h"
#import "UIDevice-Hardware.h"
#import "YRImageDownloader.h"


#define kAnimationTime 0.5

@interface TributeViewController (){
    @private
    CGRect presentRect;
    
    BOOL imageIsCurrentlyDownloading;    
    
}

- (void)flagTribute:(UIButton *)sender;
- (void)closeTribute:(UIButton *)sender;

- (void)downloadImageFromTribute:(YRTribute *)aTribute;
- (void)didFinishDownloadingImage:(UIImage *)image;

@end

@implementation TributeViewController
@synthesize closeButton;
@synthesize flagButton;
@synthesize titleLabel;
@synthesize authorLabel;
@synthesize imageView;
@synthesize tributeTextView;

@synthesize presenting, delegate;

- (void)viewDidLoad{
    
    [closeButton addTarget:self action:@selector(closeTribute:) forControlEvents:UIControlEventTouchUpInside];
    
    [flagButton addTarget:self action:@selector(flagTribute:) forControlEvents:UIControlEventTouchUpInside];
    
    imageView.layer.borderWidth = 10.f;
    imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    imageView.layer.shadowOpacity = 0.3;
    imageView.layer.shadowColor = [[UIColor blackColor] CGColor];
    imageView.layer.shadowRadius = 3;
    imageView.layer.shadowOffset = CGSizeMake(0, 5);
    
    presenting = NO;
    
}

- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setAuthorLabel:nil];
    [self setImageView:nil];
    [self setTributeTextView:nil];
    [self setCloseButton:nil];
    [self setFlagButton:nil];
    [super viewDidUnload];
}

- (void)setTribute:(YRTribute *)tribute {
    
    titleLabel.text = tribute.title;
    authorLabel.text = tribute.author;
    
    if (tribute.imageUrl) {
        [self downloadImageFromTribute:tribute];
    }else{
        //TODO: resize textView to fill empty space
    }
    
    tributeTextView.text = tribute.message;
    
    
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



- (void)downloadImageFromTribute:(YRTribute *)tribute {
    
    if (imageIsCurrentlyDownloading != YES) {
        
        YRImageDownloader *imageDownloader = [[YRImageDownloader alloc] init];
        [imageDownloader setDelegate:self];
        [imageDownloader startDownloadWithTribute:tribute];
        
        imageIsCurrentlyDownloading = YES;
        
    }
    
}

- (void)didFinishDownloadingImage:(UIImage *)image {
    
    imageView.image = image;
    
    imageIsCurrentlyDownloading = NO;
    
}

@end
