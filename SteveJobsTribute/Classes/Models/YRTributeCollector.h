//
//  YRTributeCollector.h
//  SteveJobsTribute
//
//  Created by Jack Perry on 7/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRTributeCollector : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    
    NSMutableArray                 *tributeObjects;
    
}

@property (nonatomic, retain) NSMutableArray *tributeObjects;


- (void)collectTributes;


@end
