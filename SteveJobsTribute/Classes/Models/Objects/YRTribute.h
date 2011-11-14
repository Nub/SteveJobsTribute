//
//  YRTribute.h
//  SteveJobsTribute
//
//  Created by Jack Perry on 7/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTributesArrayKey @"Starred_Tributes"

@interface YRTribute : NSObject {
    
    NSString                *mainText;
    NSString                *header;
    NSString                *author;
    NSString                *location;
    
    
    NSInteger               databaseRow;
    
}


@property (nonatomic, retain) NSString *mainText;
@property (nonatomic, retain) NSString *header;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *location;

@property (nonatomic) NSInteger databaseRow;


- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (id)tributeWithDictionary:(NSDictionary *)dictionary;


@end
