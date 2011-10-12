//
//  TributeView.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "TributeView.h"

#import <QuartzCore/QuartzCore.h>

#define kContentPadding 20.0
#define kContentDoublePadding (kContentPadding * 2.f)

@interface TributeView (){
    @private
    
    UIImageView *backgroundView;
    
    UILabel *titleLabel;
    UILabel *authorLabel;
    
    UIImageView *imageView;
    CGRect imageViewRect;
    
    UITextView *messageView;
    
    BOOL imageIsCurrentlyDownloading;
    
}

- (void)setupSubviews;
- (void)downloadImageFromTribute:(YRTribute *)tribute;


@end

@implementation TributeView


@synthesize tribute;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
             self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        [self setupSubviews];
        
        
    }
    return self;
}

- (void)setupSubviews{
    
    CGFloat lastBottom = 0;
    
    self.clipsToBounds = YES;
    
    backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tribute-background"]];
    backgroundView.frame = self.bounds;
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:backgroundView];

    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kContentPadding, kContentDoublePadding, self.frame.size.width - kContentDoublePadding, 45)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:36];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.minimumFontSize = 10;
    titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = tribute.title;
    titleLabel.numberOfLines = 5;
    [self addSubview:titleLabel];
    lastBottom = kContentDoublePadding + 45;

    
    
    authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(kContentPadding, lastBottom, self.frame.size.width - kContentDoublePadding, 20)];
    authorLabel.backgroundColor = [UIColor clearColor];
    authorLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:20];
    authorLabel.adjustsFontSizeToFitWidth = YES;
    authorLabel.minimumFontSize = 10;
    authorLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    authorLabel.textAlignment = UITextAlignmentCenter;
    authorLabel.text = tribute.author;
    authorLabel.numberOfLines = 5;
    [self addSubview:authorLabel];
    lastBottom += kContentPadding + 20;

    
    CGFloat imageViewHeight = tribute.imageSize.height;
    imageViewRect = CGRectMake(kContentPadding + (self.frame.size.width/2) - (tribute.imageSize.width/2),lastBottom,tribute.imageSize.width, tribute.imageSize.height);
    
    
    messageView = [[UITextView alloc] initWithFrame:CGRectMake(kContentPadding, lastBottom + imageViewHeight, self.frame.size.width - kContentDoublePadding, self.frame.size.height - lastBottom - kContentPadding)];
    messageView.backgroundColor = [UIColor clearColor];
    messageView.text = tribute.message;
    messageView.font = [UIFont fontWithName:@"Noteworthy-Bold" size:18];
    messageView.textAlignment = UITextAlignmentCenter;
    [self addSubview:messageView];
    
    
    
}

- (void)layoutSubviews{
    
    CGFloat lastBottom = 0;
    
    titleLabel.frame = CGRectMake(kContentPadding, kContentDoublePadding, self.frame.size.width - kContentDoublePadding, 45);
    lastBottom = kContentDoublePadding + 45;

    authorLabel.frame = CGRectMake(kContentPadding, lastBottom, self.frame.size.width - kContentDoublePadding, 20);
    lastBottom += kContentPadding + 20;

    imageViewRect = CGRectMake(kContentPadding + (tribute.imageSize.width/2) + kContentPadding,lastBottom,tribute.imageSize.width, tribute.imageSize.height);
    
    messageView.frame = CGRectMake(kContentPadding, lastBottom + tribute.imageSize.height, self.frame.size.width - kContentDoublePadding, self.frame.size.height - lastBottom - kContentPadding);
    
    
}

- (void)setTribute:(YRTribute *)newTribute{
    
    if (!newTribute)
        return;
        
    tribute = newTribute;
    
    titleLabel.text = tribute.title;
    authorLabel.text = tribute.author;

    messageView.text = tribute.message;
    
    [self layoutSubviews];
    
    // if (tribute.image != nil)
        [self downloadImageFromTribute:tribute];
    
    
    [self setNeedsDisplay];
    
}

+ (TributeView*)tributeViewFromTribute:(YRTribute*)tribute{
    
    TributeView *tributeView = [[TributeView alloc] initWithFrame:CGRectMake(0, 0, 480, 640)];
    
    [tributeView setTribute:tribute];
    
    return tributeView; 
}

- (void)downloadImageFromTribute:(YRTribute *)aTribute {
    
    if (imageIsCurrentlyDownloading != YES) {
        
        YRImageDownloader *imageDownloader = [[YRImageDownloader alloc] init];
        [imageDownloader setDelegate:self];
        [imageDownloader startDownloadWithTribute:aTribute];
        
        imageIsCurrentlyDownloading = YES;
        
    }
    
}

- (void)didFinishDownloadingImage:(UIImage *)image {
    
    imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = imageViewRect;
    imageView.layer.borderWidth = 10.f;
    imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    imageView.layer.shadowOpacity = 0.3;
    imageView.layer.shadowColor = [[UIColor blackColor] CGColor];
    imageView.layer.shadowRadius = 3;
    imageView.layer.shadowOffset = CGSizeMake(0, 5);
    [self addSubview:imageView];
    
    imageIsCurrentlyDownloading = NO;
    
}

@end
