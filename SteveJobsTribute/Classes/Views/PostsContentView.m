//
//  PostsContentView.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/6/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "PostsContentView.h"
#import "UIColor+Additions.h"

#import <QuartzCore/QuartzCore.h>

#define kPostSquareSize 200.f
#define kPostSquarePadding 25.f


@interface PostsContentView (){
    @private
    NSInteger postCount;
    
    CALayer *contentLayer;
    
}

@end

@implementation PostsContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        postCount = 0;
                
        contentLayer = [CALayer layer];
        contentLayer.frame = CGRectMake(kPostSquarePadding, kPostSquarePadding, self.frame.size.width - (kPostSquarePadding * 2), self.frame.size.height - (kPostSquarePadding * 2));
        contentLayer.backgroundColor = [[UIColor clearColor] CGColor];
        
        [self.layer addSublayer:contentLayer];
        
        [self addPosts:10];

        
    }
    return self;
}

- (void)layoutSubviews{
    
    [self layoutSublayersOfLayer:contentLayer];
    
    [super layoutSubviews];
    
}

- (void)layoutSublayersOfLayer:(CALayer *)parentLayer{
    
    NSInteger rows = floorf(self.frame.size.height / (kPostSquareSize + (kPostSquarePadding * 2)));
    
    NSLog(@"%@", self);
    
    NSInteger i = 0;
    
    for (CALayer *layer in parentLayer.sublayers) {
        
        CGFloat x = ((i - (i%rows))/rows) * (kPostSquareSize + kPostSquarePadding);
        CGFloat y = (i % rows) * (kPostSquareSize + kPostSquarePadding);
        
        CGRect newFrame = CGRectMake(x, y, kPostSquareSize, kPostSquareSize);
        
        layer.frame = newFrame;
        
        i ++;
    }
    
    [super layoutSublayersOfLayer:parentLayer];
    
}

#pragma mark - Public Methods

- (void)addPost{
        
    
    CALayer *newLayer = [CALayer layer];
    
    NSInteger rows = ceilf(self.frame.size.height / (kPostSquareSize + (kPostSquarePadding * 2)));
    
    CGFloat x = ((postCount - (postCount%rows))/rows) * (kPostSquareSize + kPostSquarePadding);
    CGFloat y = (postCount % rows) * (kPostSquareSize + kPostSquarePadding);
    
    CGRect newFrame = CGRectMake(x, y, kPostSquareSize, kPostSquareSize);
    
    newLayer.frame = newFrame;
    newLayer.backgroundColor = [[UIColor randomColor] CGColor];
    newLayer.cornerRadius = 10.f;
    
    [contentLayer addSublayer:newLayer];
    
    postCount ++;

    
}

- (void)addPosts:(NSInteger)count{
    
    for (NSInteger i = 0; i < count; i++) {
        [self addPost];
    }
    
}


@end
