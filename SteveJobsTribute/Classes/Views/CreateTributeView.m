//
//  CreateTributeView.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "CreateTributeView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Additions.h"


#define kPadding 20.f
#define kTextFieldWidth 180.f
#define kTextFieldHeight 40.f
#define kTextFieldX 130.f
#define kTextFieldInset 12.f

#define kLabelWidth 110.f
#define kLabelX 50.f

@interface CreateTributeView ()
{
    @private
    
    UITextField *titleField;
    UITextField *authorField;
    UITextView *messageField;
    
    UIImage *selectedImage;
    
    BOOL editing;
}

@end

@implementation CreateTributeView

@synthesize cancelButton;
@synthesize sendButton;
@synthesize photoButton;

- (id)initWithFrame:(CGRect)frame
{
    
    //ignore frame.size 1 size here
    frame.size = CGSizeMake(480, 640);

    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowRadius = 10.f;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(0, 10.f);
        
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
                
        UIImageView* backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tribute-create-background"]];
        backgroundView.frame = self.bounds;
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:backgroundView];
        
        UIImageView* inputBoxes = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tribute-input-boxes"]];
        inputBoxes.frame = self.bounds;
        inputBoxes.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:inputBoxes];
        
        
        CGFloat cumulativeY = 90.f;
        
        titleField = [[UITextField alloc] initWithFrame:CGRectMake(kTextFieldX, cumulativeY, kTextFieldWidth, 20.f)];
        titleField.placeholder = @"Create a title";
        titleField.delegate = self;

        [self addSubview:titleField];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelX, cumulativeY, kLabelWidth, 20.f)];
        titleLabel.text = @"Title";
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        
        cumulativeY += kTextFieldHeight + kPadding;
        
        authorField = [[UITextField alloc] initWithFrame:CGRectMake(kTextFieldX, cumulativeY, kTextFieldWidth, 20.f)];
        authorField.placeholder = @"Enter your name";
        authorField.delegate = self;
        [self addSubview:authorField];
        
        UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelX, cumulativeY, kLabelWidth, 20.f)];
        authorLabel.text = @"Author";
        authorLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:authorLabel];
        
        cumulativeY += kTextFieldHeight + kPadding;
        
        messageField = [[UITextView alloc] initWithFrame:CGRectMake(kTextFieldX, cumulativeY - 8, 305.f, 334.f)];
        messageField.text = @"Show your Inspiration";
        messageField.backgroundColor = [UIColor clearColor];
        messageField.font = authorLabel.font;
        messageField.textColor = [UIColor lightGrayColor];
        messageField.delegate = self;
        [self addSubview:messageField];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelX, cumulativeY, kLabelWidth, 20.f)];
        messageLabel.text = @"Message";
        messageLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:messageLabel];
                
        photoButton = [[UIButton alloc] initWithFrame:CGRectMake(375, 120, 26, 22)];
        photoButton.backgroundColor = [UIColor clearColor];
        [photoButton setBackgroundImage:[UIImage imageNamed:@"photos"] forState:UIControlStateNormal];
        
        [self addSubview:photoButton]; 
        
        UIImage *cancelButtonBackground = [UIImage imageNamed:@"tribute-cancel-button"];
        cancelButtonBackground = [cancelButtonBackground stretchableImageWithLeftCapWidth:4 topCapHeight:0];
        
        cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 8, 70, 31)];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:cancelButtonBackground forState:UIControlStateNormal];
        [self addSubview:cancelButton];
        
        UIImage *sendButtonBackground = [UIImage imageNamed:@"tribute-send-button"];
        sendButtonBackground = [sendButtonBackground stretchableImageWithLeftCapWidth:4 topCapHeight:0];
        
        sendButton = [[UIButton alloc] initWithFrame:CGRectMake(400, 8, 70, 31)];
        sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [sendButton setTitle:@"Send" forState:UIControlStateNormal];
        [sendButton setBackgroundImage:sendButtonBackground forState:UIControlStateNormal];
        [self addSubview:sendButton];
        
        editing = NO;
        
    }
    return self;
}

- (YRTribute*)tributeFromInput{
    
    YRTribute *newTribute = [[YRTribute alloc] init];
    
    newTribute.title = titleField.text;
    newTribute.author = authorField.text;
    newTribute.message = messageField.text;
    
    if (selectedImage) {
        
        CGRect maxImageRect = CGRectMake(0, 0, self.frame.size.width - (kPadding * 2), 250);
        
        newTribute.image = [selectedImage imageFittingToRect:maxImageRect maintainAspect:YES];
    }
    
    return newTribute;
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    CGFloat yTrans = 0;
    
    if (UIDeviceOrientationIsLandscape(orientation)) {
        
        yTrans = - 85;
        
    }else{
        
        yTrans = - 150;
        
    }
    
    [UIView animateWithDuration:0.5 animations:^(){
        self.layer.transform = CATransform3DMakeTranslation(0, yTrans, 0);
    }];
    
    editing = YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (!editing)
    [UIView animateWithDuration:0.5 animations:^(){
        self.layer.transform = CATransform3DIdentity;
    }];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    CGFloat yTrans = 0;
    
    if (UIDeviceOrientationIsLandscape(orientation)) {
        
        yTrans = - 85;
        
    }else{
        
        yTrans = - 150;
        
    }
    
    [UIView animateWithDuration:0.5 animations:^(){
        self.layer.transform = CATransform3DMakeTranslation(0, yTrans, 0);
    }];
    
    if ([textView.text isEqualToString:@"Show your Inspiration"]){
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }
    
    editing = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@""]) {
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Show your Inspiration";
    }
    
    if (!editing)
    [UIView animateWithDuration:0.5 animations:^(){
        self.layer.transform = CATransform3DIdentity;
    }];
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if(!selectedImage)
        selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
}


@end
