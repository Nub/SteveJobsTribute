//
//  CreateTributeView.h
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTribute.h"

@interface CreateTributeView : UIView
{
    
    UIButton *cancelButton;
    UIButton *sendButton;
    
}

@property (nonatomic, readonly) UIButton *cancelButton;
@property (nonatomic, readonly) UIButton *sendButton;

- (YRTribute*)tributeFromInput;

- (void)focusMessage;

@end
