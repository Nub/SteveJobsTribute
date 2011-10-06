//
//  SJTSlideShowView.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/5/11.
//  Copyright (c) 2011 Zachry Thayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SJTSlideShowView : UIView
{
    
    NSMutableArray *slides;
    NSInteger currentSlide;
    
    CALayer *thisSlide, *nextSlide;
    
    NSMutableArray *transitions;
    
}

@property (nonatomic, retain) NSMutableArray *slides;
@property (nonatomic) NSInteger currentSlide;

- (void)play;

@end
