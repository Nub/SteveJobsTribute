//
//  YRAnalytics.h
//  YRAnalytics
//
//  Created by Jack Perry on 29/09/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRAnalytics : NSObject {
    
    NSString            *APIKey;
    
}

@property (nonatomic, retain) NSString *APIKey;


/* YRAnalytics */
- (id)initWithAPIKey:(NSString *)key;


/* YRDeviceRegistration */
- (void)registerDeivceWithApplicationIdentifier:(NSString *)applicationIdentifier;


@end
