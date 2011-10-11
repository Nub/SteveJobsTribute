//
//  YRTribute.m
//  SteveJobsTribute
//
//  Created by Jack Perry on 7/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "YRTribute.h"

@implementation YRTribute

@synthesize title, author, message, image, imageUrl, imageSize, device, posted, flagged, databaseRow, identifier;


+ (id)tributeWithDictionary:(NSDictionary *)dictionary {
    
    return [[self alloc] initWithDictionary:dictionary];
    
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dictionary];
        
    }
    
    return self;
    
}


@end
