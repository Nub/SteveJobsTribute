//
//  UIDevice+Additions.m
//  Frequencies
//
//  Created by Jack Perry on 10/09/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//


#include <sys/socket.h> 
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/types.h>


#import "UIDevice+Additions.h"
#import "NSString+Additions.h"


@implementation UIDevice (Additions)


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UDID Replacement

- (NSString *)macAddress {
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", 
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outString;
    
}

- (NSString *)uniqueDeviceIdentifier {
    
    NSString *macAddress = [[UIDevice currentDevice] macAddress];
    NSString *uniqueIdentifier = [macAddress MD5EncryptString];
    
    return uniqueIdentifier;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Hadware Additions
- (NSString *)platform {
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    
    free(machine);
    return platform;
    
}



@end
