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

#define kPostSquareSize 100.f
#define kPostSquarePadding 5.f


@interface PostsContentView (){
    @private
    NSInteger postCount;
    
    
    UIImage *postIt;
    
}

@end

@implementation PostsContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        postCount = 0;
        
        postIt = [UIImage imageNamed:@"postIt"];
        
    }
    return self;
}

- (void)layoutSubviews{
        
     [super layoutSubviews];
    
    NSInteger rows = floorf((self.frame.size.height - (kPostSquarePadding * 2)) / (kPostSquareSize + (kPostSquarePadding)));
    
    NSInteger i = 0;
    
    for (UIView *view in self.subviews) {
        
        CGFloat x = kPostSquarePadding + ((i - (i%rows))/rows) * (kPostSquareSize + kPostSquarePadding);
        CGFloat y = kPostSquarePadding + (i % rows) * (kPostSquareSize + kPostSquarePadding);
        
        CGRect newFrame = CGRectMake(x, y, kPostSquareSize, kPostSquareSize);
        
        view.frame = newFrame;
        
        i ++;
    }
        
}

#pragma mark - Public Methods
#define ARC4RANDOM_MAX      0x100000000

- (void)addPost{
        
    
    UIView *newView = [[UIView alloc] init];
    
    NSInteger rows = ceilf(self.frame.size.height / (kPostSquareSize + (kPostSquarePadding * 2)));
    
    CGFloat x = ((postCount - (postCount%rows))/rows) * (kPostSquareSize + kPostSquarePadding);
    CGFloat y = (postCount % rows) * (kPostSquareSize + kPostSquarePadding);
    
    CGRect newFrame = CGRectMake(x, y, kPostSquareSize, kPostSquareSize);
    
    CGFloat rot = (((CGFloat)arc4random() / ARC4RANDOM_MAX) * 0.1) - 0.05;
    
    CATransform3D newTransform = CATransform3DMakeRotation(rot, 0, 0, 1);
    newTransform.m34 = -1.0f/500.f;
    
    newView.frame = newFrame;
    newView.layer.transform = newTransform;

    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"postIt"]];
    backgroundView.frame = newView.bounds;
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [newView addSubview:backgroundView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kPostSquareSize - 20, 25)];
    title.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleBottomMargin;
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont fontWithName:@"Bradley Hand" size:10];
    title.adjustsFontSizeToFitWidth = YES;
    title.minimumFontSize = 10;
    title.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    title.text = [NSString stringWithFormat:@"Title #%i", postCount];
    title.numberOfLines = 3;
    
    [newView addSubview:title];
    
    [self addSubview:newView];
    
    postCount ++;

    
}

- (void)addPosts:(NSInteger)count{
    
    for (NSInteger i = 0; i < count; i++) {
        [self addPost];
    }
    
}

- (UIView *)getPost:(NSInteger)postIndex{
    
    UIView *focusView = [[self subviews] objectAtIndex:postIndex];
    
    if (!focusView)
        return nil;
    else
        return focusView;
    
    
}

- (CGSize)postsContentSize{
    
    NSInteger rows = ceilf(self.frame.size.height / (kPostSquareSize + (kPostSquarePadding * 2)));
    NSInteger columns = floorf(postCount / rows);
    
    return CGSizeMake(kPostSquarePadding + (columns * kPostSquareSize) + (columns * kPostSquarePadding), kPostSquarePadding + (rows * kPostSquareSize) + (rows * kPostSquarePadding));
    
}


@end
