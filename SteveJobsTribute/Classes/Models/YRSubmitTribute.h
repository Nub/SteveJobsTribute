//
//  YRSubmitTribute.h
//  SteveJobsTribute
//
//  Created by Jack Perry on 12/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "YRTribute.h"


@protocol YRSubmitTributeDelegate;

@interface YRSubmitTribute : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    
    id <YRSubmitTributeDelegate> delegate;
    
    
@private
    NSMutableData           *connectionBuffer;
    
}


@property (nonatomic, retain) id <YRSubmitTributeDelegate> delegate;


- (void)submitTribute:(YRTribute *)tribute;


@end



@protocol YRSubmitTributeDelegate <NSObject>

- (void)tributeWasSubmittedtoServer;

@optional
- (void)didFailToSubmitTribute:(NSError *)error;

@end
