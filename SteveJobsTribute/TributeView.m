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
    
    UITextView *messageView;
    
}

- (void)setupSubviews;



@end

@implementation TributeView

@synthesize title;
@synthesize author;
@synthesize message;
@synthesize image;

@synthesize tribute;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        title = tribute.title;
        author = tribute.author;
        message = tribute.message;
        image = tribute.image;
        
        /*title = @"Title";
        author = @"Author";
        message = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque nec sapien justo, vel sollicitudin lacus. Aliquam erat volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mollis risus convallis est adipiscing tempus egestas ligula viverra. In hac habitasse platea dictumst. Donec nibh leo, scelerisque vitae ornare et, laoreet at ante. Donec eget venenatis massa. Morbi nec blandit elit. Aenean bibendum feugiat lectus. ";
        image = nil;*/
        
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
    titleLabel.text = title;
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
    authorLabel.text = author;
    authorLabel.numberOfLines = 5;
    [self addSubview:authorLabel];
    lastBottom += kContentPadding + 20;

    
    CGFloat imageViewHeight = 0;
    
    messageView = [[UITextView alloc] initWithFrame:CGRectMake(kContentPadding, lastBottom + imageViewHeight, self.frame.size.width - kContentDoublePadding, self.frame.size.height - lastBottom - kContentPadding)];
    messageView.backgroundColor = [UIColor clearColor];
    messageView.text = message;
    messageView.font = [UIFont fontWithName:@"Noteworthy-Bold" size:18];
    messageView.textAlignment = UITextAlignmentCenter;
    [self addSubview:messageView];
    
    
    
}

- (void)setTribute:(YRTribute *)newTribute{
    
    if (!newTribute)
        return;
        
    tribute = newTribute;
    
    [self setTitle:   tribute.title];
    [self setAuthor:  tribute.author];
    [self setMessage: tribute.message];
    [self setImage:   tribute.image];
    
    [self setNeedsDisplay];
    
}

- (void)setTitle:(NSString *)newTitle{
    
    title = newTitle;
    titleLabel.text = title;
    
}

- (void)setAuthor:(NSString *)newAuthor{
    
    author = newAuthor;
    authorLabel.text = author;
    
}

- (void)setMessage:(NSString *)newMessage{
        
    message = newMessage;
    messageView.text = message;
    
}

- (void)setImage:(NSURL *)newImage{
    
    image = newImage;
    //TODO: Implement async image download
    
}


@end
