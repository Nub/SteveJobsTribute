//
//  YRReportMessage.m
//  SteveJobsTribute
//
//  Created by Jack Perry on 11/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "JSONKit.h"
#import "NSString+Additions.h"

#import "YRReportMessage.h"

@interface YRReportMessage ()

- (NSData *)jsonHttpBodyWithTributeIdentifier:(NSInteger)identifier;

@end

@implementation YRReportMessage
@synthesize delegate;


#pragma mark - Public Methods
- (void)reportTribute:(YRTribute *)tribute {
    
    NSData *jsonHttpBody = [self jsonHttpBodyWithTributeIdentifier:tribute.identifier];
    
    NSURL *url = [NSURL URLWithString:@"http://ttribute.frequenciesapp.com/api/v2/"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:30.0];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:jsonHttpBody];
    
    
    if (connectionBuffer == nil)
        connectionBuffer = [[NSMutableData alloc] init];
    
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [urlConnection start];

    
}


#pragma mark - Private Methods
- (NSData *)jsonHttpBodyWithTributeIdentifier:(NSInteger)identifier {
    
    NSString *apiToken = [[[[NSBundle mainBundle] bundleIdentifier] reverse] MD5EncryptString];
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithInt:identifier], @"tribute_id",
                          nil];
    
    NSDictionary *json = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"ReportTributeMessage", @"method",
                          apiToken, @"api_token",
                          data, @"data",
                          nil];
    
    NSData *httpBody = [json JSONData];
    
    
    return httpBody;
    
}


#pragma mark - NSURLconnection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [connectionBuffer setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [connectionBuffer appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [delegate didFinishReportingTribute];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [delegate didFailToReportTribute:error];
    
}

@end
