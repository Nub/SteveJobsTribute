//
//  YRSubmitTribute.m
//  SteveJobsTribute
//
//  Created by Jack Perry on 12/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "YRSubmitTribute.h"

@interface YRSubmitTribute ()

- (NSData *)jsonHttpBodyWithTribute:(YRTribute *)tribute;

@end


@implementation YRSubmitTribute
@synthesize delegate;


- (void)submitTribute:(YRTribute *)tribute {
    
    NSData *jsonHttpBody = [self jsonHttpBodyWithTribute:tribute];
    

    
}




@end
