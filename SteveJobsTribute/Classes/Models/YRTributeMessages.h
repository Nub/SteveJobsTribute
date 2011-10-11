//
//  YRTributeMessages.h
//  SteveJobsTribute
//
//  Created by Jack Perry on 11/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YRTributeMessagesManager;

@interface YRTributeMessages : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    
    id <YRTributeMessagesManager>   delegate;
    
    NSMutableArray                  *tributeObjects;
    
@private
    NSMutableData                   *connectionBuffer;
    
    
}

@property (nonatomic, retain) id <YRTributeMessagesManager> delegate;
@property (nonatomic, retain) NSMutableArray *tributeObjects;


- (void)tributeMessagesFromOffset:(int)offset withRange:(int)range;

@end


@protocol YRTributeMessagesManager

- (void)didFinishLoadingTributes:(NSArray *)tributeObjects;


@optional
- (void)didFailLoadingTributes:(NSError *)error;


@end