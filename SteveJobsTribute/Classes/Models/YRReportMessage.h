//
//  YRReportMessage.h
//  SteveJobsTribute
//
//  Created by Jack Perry on 11/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "YRTribute.h"

#import <Foundation/Foundation.h>

@protocol YRReportMessageDelegate;

@interface YRReportMessage : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    
    id <YRReportMessageDelegate> delegate;
    
@private
    NSMutableData               *connectionBuffer;
    
}

@property (nonatomic, retain) id <YRReportMessageDelegate> delegate;

- (void)reportTribute:(YRTribute *)tribute;

@end


@protocol YRReportMessageDelegate <NSObject>

- (void)didFinishReportingTribute;

@optional
- (void)didFailToReportTribute:(NSError *)error;

@end