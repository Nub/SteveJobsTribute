//
//  YRImageDownloader.h
//  SteveJobsTribute
//
//  Created by Jack Perry on 11/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "YRTribute.h"
#import <Foundation/Foundation.h>

@protocol YRImageDownloaderDelegate;

@interface YRImageDownloader : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> { 
    
    YRTribute                   *tribute;
    NSMutableData               *activeDownloadBuffer;
    NSURLConnection             *activeConnection;
    
    id <YRImageDownloaderDelegate> delegate;
    
}


@property (nonatomic, retain) YRTribute *tribute;
@property (nonatomic, retain) NSMutableData *activeDownloadBuffer;
@property (nonatomic, retain) NSURLConnection *activeConnection;

@property (nonatomic, retain) id <YRImageDownloaderDelegate> delegate;

- (void)startDownloadWithTribute:(YRTribute *)aTribute;
- (void)cancelDownload;

@end


@protocol YRImageDownloaderDelegate <NSObject>

- (void)didFinishDownloadingImage:(UIImage *)image;

@end