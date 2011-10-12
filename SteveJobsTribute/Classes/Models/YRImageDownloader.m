//
//  YRImageDownloader.m
//  SteveJobsTribute
//
//  Created by Jack Perry on 11/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "YRImageDownloader.h"

@implementation YRImageDownloader
@synthesize tribute, activeDownloadBuffer, activeConnection, delegate;


#pragma mark - Public Methods
- (void)startDownloadWithTribute:(YRTribute *)aTribute {
    
    self.tribute = aTribute;
    self.activeDownloadBuffer = [NSMutableData data];
    
    
    NSURL *downloadUrl = self.tribute.imageUrl;
    NSURLRequest *downloadRequest = [[NSURLRequest alloc] initWithURL:downloadUrl cachePolicy:NSURLCacheStorageAllowed timeoutInterval:30.0];
    
    NSURLConnection *downloadConnection = [[NSURLConnection alloc] initWithRequest:downloadRequest delegate:self startImmediately:YES];
    self.activeConnection = downloadConnection;
    
}

- (void)cancelDownload {
    
    [self.activeConnection cancel];
    self.activeConnection = nil;
    self.activeDownloadBuffer = nil;
    
}


#pragma mark - Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.activeDownloadBuffer appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [self cancelDownload];
    NSLog(@"Failed to download image, %@", error);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownloadBuffer];
    self.tribute.image = image;

    
    /* Reset all fields */
    [self cancelDownload];
    
    
    [delegate didFinishDownloadingImage:image];
}


@end
