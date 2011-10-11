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
    
    
    UIImage             *image;
    NSURL               *imageUrl;
    CGSize              imageSize;
    
    NSDate              *posted;
    
    
    BOOL                flagged;
    NSInteger           databaseRow;
    NSInteger           identifier;
    
}


@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *device;

@property (nonatomic, retain) NSURL *imageUrl;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) CGSize imageSize;

@property (nonatomic, retain) NSDate *posted;

@property (nonatomic) BOOL flagged;
@property (nonatomic) NSInteger databaseRow;
@property (nonatomic) NSInteger identifier;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (id)tributeWithDictionary:(NSDictionary *)dictionary;


@end
