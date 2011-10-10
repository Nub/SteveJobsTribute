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
#define kPostSquarePadding 20.f
#define kPostSquareSize2 170.f




@interface CorkboardContentView (){
    @private
    NSInteger postCount;
    
    NSInteger focusedPost;
    
    UIImage *postIt;
    
}

- (CGRect)frameForIndex:(NSInteger)index;
- (void)buildGrid;

@end

@implementation CorkboardContentView

@synthesize layoutOrientation;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        postCount = 0;
        focusedPost = -1;
        layoutOrientation = UIDeviceOrientationLandscapeLeft;
        
    }
    return self;
}


#pragma mark - Public Methods

#define arc4randPM(value)((((CGFloat)arc4random() / 0x100000000) - 0.5) * value * 2.f)

- (void)addPost:(NSString *)title{
        
    
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
    titleLabel.font = [UIFont fontWithName:@"Bradley Hand" size:18];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.minimumFontSize = 10;
    titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.numberOfLines = 5;
    
    [newView addSubview:titleLabel];
    
    [self addSubview:newView];
    
    postCount ++;

    
}

- (void)addPosts:(NSArray*)titles{
    
    for (NSString *title in titles) {
        [self addPost:title];
    }
    
    [self buildGrid];
        
}

- (UIView *)focusPost:(NSInteger)postIndex completion:(void (^)(BOOL finished))completionBlock{
    
    UIView *focusView = [self.subviews  objectAtIndex:postIndex];
    
    if (focusView){
        
        CGRect newFrame = focusView.frame;
        newFrame.size.width = 480;
        newFrame.size.height = 640;
        
        if (UIDeviceOrientationIsLandscape(layoutOrientation)){
            
            newFrame.origin.x = 272;
            newFrame.origin.y = 64;

        }else{
            
            newFrame.origin.x = 144;
            newFrame.origin.y = 192;

        }
        
        
        [UIView animateWithDuration:2 animations:^(void){
            
            focusView.frame = newFrame;
            
        } completion:completionBlock];
        

    }else
        return nil;
    
    return focusView;
    
}

#pragma mark - Setters / Getters

- (void)setLayoutOrientation:(UIDeviceOrientation)newOrientation{
    
    layoutOrientation = newOrientation;
    
    [self buildGrid];
    
    
}

#pragma mark - Private Helpers

- (CGRect)frameForIndex:(NSInteger)i{
    
    if (UIDeviceOrientationIsLandscape(layoutOrientation)) {//Horizontal scroll
        
        NSInteger rows = floorf(([self superview].frame.size.height - (kPostSquarePadding * 2)) / (kPostSquareSize + (kPostSquarePadding)));
            
        CGFloat x = arc4randPM(kPostSquarePadding - 5) + kPostSquarePadding - 10 + ((i - (i%rows))/rows) * (kPostSquareSize + kPostSquarePadding);
        CGFloat y = arc4randPM(kPostSquarePadding - 5) + (kPostSquarePadding*2) + (i % rows) * (kPostSquareSize + kPostSquarePadding);
        
        return CGRectMake(x, y, kPostSquareSize, kPostSquareSize);
         
        
        
    }else{//Portait vertical scroll
        
        NSInteger columns = floorf(([self superview].frame.size.width - (kPostSquarePadding * 2)) / (kPostSquareSize + (kPostSquarePadding)));
        
        CGFloat x = arc4randPM(kPostSquarePadding - 5) + kPostSquarePadding + (i % columns) * (kPostSquareSize2 + kPostSquarePadding);
        CGFloat y = arc4randPM(kPostSquarePadding - 5) + kPostSquarePadding + ((i - (i%columns))/columns) * (kPostSquareSize2 + kPostSquarePadding);
        
        return CGRectMake(x, y, kPostSquareSize2, kPostSquareSize2);
            
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
