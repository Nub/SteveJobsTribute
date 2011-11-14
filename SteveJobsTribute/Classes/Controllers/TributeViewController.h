//
//  TributeViewController.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "YRTribute.h"

@protocol TributeViewControllerDelegate

- (void)didCloseTribute;

@end

@interface TributeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIButton *starButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *tributeTextView;

@property (nonatomic, getter = isPresenting) BOOL presenting;

@property (nonatomic, retain) id <TributeViewControllerDelegate> delegate;

- (void)setTribute:(YRTribute *)tribute;

- (void)presentViewFromRect:(CGRect)fromRect inView:(UIView*)aView;

- (void)hideViewToRect:(CGRect)toRect;

@end
