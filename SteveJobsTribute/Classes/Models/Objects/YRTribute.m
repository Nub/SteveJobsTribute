//
//  YRTribute.m
//  SteveJobsTribute
//
//  Created by Jack Perry on 7/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "YRTribute.h"

@implementation YRTribute

@synthesize mainText, header, author, location, databaseRow;


+ (id)tributeWithDictionary:(NSDictionary *)dictionary {
    
    return [[self alloc] initWithDictionary:dictionary];
    
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    
    if (self = [super init]) {
        
        NSMutableDictionary *adjustedDictionary = [NSMutableDictionary dictionary];
        
        for (NSString *key in dictionary) {
            id object = [dictionary objectForKey:key];
            
            if (![object isKindOfClass:[NSNull class]]) {
                [adjustedDictionary setObject:object forKey:key];
            }
            
        }
        
        [self setValuesForKeysWithDictionary:adjustedDictionary];
        
        
    }
    
    return self;
    
}


@end
