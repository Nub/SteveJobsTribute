//
//  CreateTributeView.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "CreateTributeView.h"
#import <QuartzCore/QuartzCore.h>

#define kPadding 20.f
#define kTextFieldWidth 270.f
#define kTextFieldHeight 40.f
#define kTextFieldX 160.f
#define kTextFieldInset 12.f

#define kLabelWidth 110.f
#define kLabelX 50.f

@implementation CreateTributeView

@synthesize cancelButton;
@synthesize sendButton;

- (id)initWithFrame:(CGRect)frame
{
    
    //ignore frame.size 1 size here
    frame.size = CGSizeMake(480, 640);

    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowRadius = 10.f;
        self.layer.shadowOpacity = 0.5;
        
        UIImageView* backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tribute-create-background"]];
        backgroundView.frame = self.bounds;
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:backgroundView];
        
        UIImageView* inputBoxes = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tribute-input-boxes"]];
        inputBoxes.frame = self.bounds;
        inputBoxes.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:inputBoxes];
        
        
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        CGFloat cumulativeY = 84.f;
        
        UITextField *titleField = [[UITextField alloc] initWithFrame:CGRectMake(kTextFieldX, cumulativeY, kTextFieldWidth, 20.f)];
        titleField.placeholder = @"Create a title";
        [self addSubview:titleField];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelX, cumulativeY, kLabelWidth, 20.f)];
        titleLabel.text = @"Title";
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        
        cumulativeY += kTextFieldHeight + kPadding;
        
        UITextField *authorField = [[UITextField alloc] initWithFrame:CGRectMake(kTextFieldX, cumulativeY, kTextFieldWidth, 20.f)];
        authorField.placeholder = @"Enter your name";
        [self addSubview:authorField];
        
        UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelX, cumulativeY, kLabelWidth, 20.f)];
        authorLabel.text = @"Author";
        authorLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:authorLabel];
        
        cumulativeY += kTextFieldHeight + kPadding;
        
        UITextView *messageField = [[UITextView alloc] initWithFrame:CGRectMake(kTextFieldX, cumulativeY - 8, kTextFieldWidth, 334.f)];
        messageField.text = @"Show your Inspiration";
        messageField.backgroundColor = [UIColor clearColor];
        messageField.font = authorLabel.font;
        [self addSubview:messageField];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelX, cumulativeY, kLabelWidth, 20.f)];
        messageLabel.text = @"Message";
        messageLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:messageLabel];
        
        cumulativeY += 338.f + kPadding;
        
        UITextField *imageField = [[UITextField alloc] initWithFrame:CGRectMake(kTextFieldX, cumulativeY, kTextFieldWidth, 20.f)];
        imageField.placeholder = @"Optionally add an image";
        [self addSubview:imageField];
        
        UILabel *imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelX, cumulativeY, kLabelWidth, 20.f)];
        imageLabel.text = @"Image";
        imageLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:imageLabel];
        
        
    }
    return self;
}

- (YRTribute*)tributeFromInput{
    
    return nil;
}

- (void)focusMessage{
    
    
}

@end
