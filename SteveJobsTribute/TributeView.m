//
//  TributeView.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "TributeView.h"

#define kContentPadding 20.f
#define kContentDoublePadding kContentPadding*2.f

@interface TributeView ()

- (void)setupSubviews;

@end

@implementation TributeView

@synthesize title;
@synthesize author;
@synthesize tribute;
@synthesize image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        
        
    }
    return self;
}

- (void)setupSubviews{

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kContentPadding, kContentPadding, self.frame.size.width - kContentDoublePadding, self.frame.size.height - kContentDoublePadding)];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleBottomMargin;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Bradley Hand" size:40];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.minimumFontSize = 10;
    titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.numberOfLines = 5;
    
    [self addSubview:titleLabel];
    
}

@end
