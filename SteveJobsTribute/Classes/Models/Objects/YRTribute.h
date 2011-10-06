//
//  YRTribute.h
//  SteveJobsTribute
//
//  Created by Jack Perry on 7/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRTribute : NSObject {
    
    
    NSString            *title;
    NSString            *author;
    NSString            *message;
    NSString            *device;
    
    
    NSURL               *image;
    NSDate              *posted;
    
    
}


@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *device;

@property (nonatomic, retain) NSURL *image;
@property (nonatomic, retain) NSDate *posted;


- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (id)tributeWithDictionary:(NSDictionary *)dictionary;


@end
