//
//  UIDevice+Additions.h
//  Frequencies
//
//  Created by Jack Perry on 10/09/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIDevice (Additions)


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UDID Replacement
- (NSString *)macAddress;
- (NSString *)uniqueDeviceIdentifier;



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Hadware Additions
- (NSString *)platform;


@end
