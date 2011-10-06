//
//  SJTSlideShowView.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/5/11.
//  Copyright (c) 2011 Zachry Thayer. All rights reserved.
//

#import "SJTSlideShowView.h"

@interface SJTSlideShowView (Private)

- (void)initialize;

- (void)createTransitions;

@end

@implementation SJTSlideShowView

@synthesize slides;
@synthesize currentSlide;

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self initialize];
        
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self initialize];
        
    }
    return self;
}

- (void)initialize{
    
    UIImage *background = [UIImage imageNamed:@"backgorund"];
    UIColor *bgColor = [UIColor colorWithPatternImage:background];
    self.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.layer.backgroundColor = [[UIColor scrollViewTexturedBackgroundColor] CGColor];

    thisSlide = [CALayer layer];
    nextSlide = [CALayer layer];
    
    thisSlide.frame = self.frame;
    nextSlide.frame = self.frame;
    
    [self.layer addSublayer:thisSlide];
    
    nextSlide.opacity = 0.0f;
    
    self.slides = [NSMutableArray array];
    
    [self createTransitions];
}

- (void)createTransitions{
    
    transitions = [NSMutableArray array];
    
    // CAAnimationGroup *transitionGroup1 = [CAAnimationGroup animation];
    
    CATransform3D translation1 = CATransform3DMakeTranslation(0, 0, -100);
    translation1.m34 = -1.0f/500.f;
    translation1 = CATransform3DRotate(translation1, -M_PI/16.f, 0, 0, 1);
    
    CABasicAnimation *transition1 = [CABasicAnimation animation];
	transition1.toValue = [NSValue valueWithCATransform3D: translation1];
	transition1.duration = 5;
	transition1.removedOnCompletion = NO;
    transition1.autoreverses = NO;
	transition1.fillMode = kCAFillModeBoth;
    
    [transitions addObject:transition1];
    
    //[container addAnimation:animation2 forKey:@"transform"];
    
    
    
}

- (void)play{
    
    CABasicAnimation *transition = [transitions objectAtIndex:0];
    
    thisSlide.contents = (id) [[slides objectAtIndex:currentSlide] CGImage];
    
    [thisSlide addAnimation:transition forKey:@"transform"];

}

@end
