//
//  YRSubmitTribute.m
//  SteveJobsTribute
//
//  Created by Jack Perry on 12/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "YRSubmitTribute.h"

#import "JSONKit.h"
#import "NSString+Additions.h"
#import "UIDevice



@interface YRSubmitTribute ()

- (NSData *)jsonHttpBodyWithTribute:(YRTribute *)tribute;

@end



@implementation YRSubmitTribute
@synthesize delegate;


- (void)submitTribute:(YRTribute *)tribute {
    
    NSData *jsonHttpBody = [self jsonHttpBodyWithTribute:tribute];
    

    
}



#pragma mark - Private Methods
- (NSData *)jsonHttpBodyWithTribute:(YRTribute *)tribute {
    
    
    NSMutableDictionary *jsonData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                     tribute.title, @"tribute_title",
                                     tribute.author, @"tribute_author",
                                     [tribute.message UTF8String], @"tribute_message",
                                     
                                     
                                     nil];
    
    
    NSString *apiToken = [[[[NSBundle mainBundle] bundleIdentifier] reverse] MD5EncryptString];
    NSDictionary *json = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"SubmitTribute", @"method",
                          apiToken, @"api_token",
                          jsonData, @"data",
                          nil];
    
    
    NSData *httpBody = [json JSONData];
    
    return httpBody;
    
}




@end
