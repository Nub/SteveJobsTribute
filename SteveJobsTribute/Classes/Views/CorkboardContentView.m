//
//  CorkboardContentView.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/6/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "CorkboardContentView.h"
#import "UIColor+Additions.h"
#import "UIView+Additions.h"

#import <QuartzCore/QuartzCore.h>

#define kPostSquareSize 150.f
#define kPostSquareSizeiPhone 120.f
#define kPostSquarePadding 20.f
#define kPostSquareSize2 170.f


@interface CorkboardContentView (){
    @private
    NSInteger postCount;
    
    NSInteger focusedPost;
    
    UIImage *postIt;
    
    BOOL deviceIsIPad;
    
}

- (CGRect)frameForIndex:(NSInteger)index;
- (void)buildGrid;

@end

@implementation CorkboardContentView

@synthesize layoutOrientation;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        postCount = 0;
        focusedPost = -1;
        layoutOrientation = [[UIDevice currentDevice] orientation];
        
        NSString *deviceModel = [[UIDevice currentDevice] model];

        NSRange modelRange = [deviceModel rangeOfString:@"iPad"];
        
        if (modelRange.location != NSNotFound) {
            
            deviceIsIPad = YES;
        
        }
    }
    return self;
}


#pragma mark - Public Methods

#define arc4randPM(value)((((CGFloat)arc4random() / 0x100000000) - 0.5) * value * 2.f)

- (void)addPosts:(NSArray *)tributeObjects {
    
    for (YRTribute *tribute in tributeObjects) {
        
        [self addPost:tribute];
        
    }
    
    [self buildGrid];
    
}

- (void)addPost:(YRTribute *)tribute {
    
    UIView *newView = [[UIView alloc] init];
    newView.frame = CGRectMake(0, 0, kPostSquareSize, kPostSquareSize);;
    
    //Add random rotation
    CGFloat rot = arc4randPM(0.2);
    
    CATransform3D newTransform = CATransform3DMakeRotation(rot, 0, 0, 1);
    newTransform.m34 = -1.0f/500.f;
    newView.layer.transform = newTransform;
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"post"]];
    backgroundView.frame = newView.bounds;
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [newView addSubview:backgroundView];
    
    UIImageView *pin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin"]];
    pin.frame = CGRectMake((kPostSquareSize*0.5f - 15) - ((rot/0.2f)*kPostSquareSize*0.35f), -5, 32, 32);
    pin.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [newView addSubview:pin];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kPostSquareSize - 30, kPostSquareSize2 - 40)];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleBottomMargin;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:18];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.minimumFontSize = 10;
    titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = tribute.title;
    titleLabel.numberOfLines = 5;
    
    [newView addSubview:titleLabel];
    
    [self addSubview:newView];
    
    postCount ++;
    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapGesture:)];
    [newView addGestureRecognizer:tapRecognizer];
    
    
}



- (CGRect)postRect:(NSInteger)postIndex{
    
    UIView *post = [[self subviews] objectAtIndex:postIndex];
    if (!post)
        return CGRectZero;
    else{
     
        UIWindow *mainWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        
        return [self convertRect:post.frame toView:mainWindow.rootViewController.view];
        
    }
}

- (CATransform3D)postTransform:(NSInteger)postIndex{
    
    UIView *post = [[self subviews] objectAtIndex:postIndex];
    if (!post)
        return post.layer.transform;
    else
        return CATransform3DIdentity;

    
}


- (void)hidePost:(NSInteger)postIndex{
    
    UIView *post = [[self subviews] objectAtIndex:postIndex];
    if (post){
        
        [UIView animateWithDuration:0.5 animations:^(){
            post.alpha = 0;
        }];
        
    }
    
}

- (void)showPost:(NSInteger)postIndex{
    
    UIView *post = [[self subviews] objectAtIndex:postIndex];
    if (post){
        
        [UIView animateWithDuration:0.5 animations:^(){
            post.alpha = 1;
        }];
        
    }
    
}


#pragma mark - UITGestureRecognizerDelegate

- (void)respondToTapGesture:(UITapGestureRecognizer*)gestureRecognizer{
    
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        
        [delegate tappedPostAtIndex:[self.subviews indexOfObject:gestureRecognizer.view]];
        
    }
    
}


#pragma mark - Setters / Getters

- (void)setLayoutOrientation:(UIDeviceOrientation)newOrientation{
    
    layoutOrientation = newOrientation;
    
    [self buildGrid];
    
    
}

#pragma mark - Private Helpers

- (CGRect)frameForIndex:(NSInteger)i{
    
    CGFloat squareSize = (deviceIsIPad)?kPostSquareSize2:kPostSquareSizeiPhone;
    
    if (UIDeviceOrientationIsLandscape(layoutOrientation)) {//Horizontal scroll
        
        NSInteger rows = floorf(([self superview].frame.size.height - (kPostSquarePadding * 2)) / (kPostSquareSize + (kPostSquarePadding)));
            
        CGFloat x = arc4randPM(kPostSquarePadding - 5) + kPostSquarePadding - 10 + ((i - (i%rows))/rows) * (kPostSquareSize + kPostSquarePadding);
        CGFloat y = 5 + arc4randPM(kPostSquarePadding - 5) + (kPostSquarePadding*2) + (i % rows) * (kPostSquareSize + kPostSquarePadding);
        
        return CGRectMake(x, y, kPostSquareSize, kPostSquareSize);
         
        
        
    }else{//Portait vertical scroll
        
        NSInteger columns = floorf(([self superview].frame.size.width - (kPostSquarePadding * 2)) / (squareSize + (kPostSquarePadding)));
        
        CGFloat x = arc4randPM(kPostSquarePadding - 5) + kPostSquarePadding + (i % columns) * (squareSize + kPostSquarePadding);
        CGFloat y = arc4randPM(kPostSquarePadding - 5) + kPostSquarePadding + ((i - (i%columns))/columns) * (squareSize + kPostSquarePadding);
        
        return CGRectMake(x, y, squareSize, squareSize);
            
    }
    
}

- (void)buildGrid{
    
    NSInteger i = 0;
    
    for (UIView *view in self.subviews) {
        
        if(i == focusedPost) continue;//skip layout of focused view
        
        [UIView animateWithDuration:0.5 animations:^(void){
            view.frame = [self frameForIndex:i];
        }];
        
        i ++;
    }
    
    
    CGRect contentsFrame = [self subviewContainerRect];
    
    if (UIDeviceOrientationIsLandscape(layoutOrientation)) {
        
        contentsFrame.size.width += kPostSquarePadding;
        contentsFrame.size.height += kPostSquarePadding;
        
    }else{
        
        contentsFrame.size.width = 768;
        //contentsFrame.size.height += kPostSquarePadding;
        
    }
    

    contentsFrame.origin = self.frame.origin;
    
    self.frame = contentsFrame;
    
}


@end
