//
//  YRTributeMessages.m
//  SteveJobsTribute
//
//  Created by Jack Perry on 11/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "JSONKit.h"
#import "YRTribute.h"
#import "YRTributeMessages.h"
#import "NSString+Additions.h"

@interface YRTributeMessages () 

- (NSData *)jsonHttpBodyWithOffset:(int)offset andRange:(int)range;

@end


@implementation YRTributeMessages

@synthesize tributeObjects, delegate;



- (void)tributeMessagesFromOffset:(int)offset withRange:(int)range {
    
    NSData *jsonHttpBody = [self jsonHttpBodyWithOffset:offset andRange:range];
    
    NSURL *url = [NSURL URLWithString:@"http://tribute.frequenciesapp.com/api/v2/"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:30.0];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:jsonHttpBody];
    
    
    if (connectionBuffer == nil)
        connectionBuffer = [[NSMutableData alloc] init];
    
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [urlConnection start];
    
}



#pragma mark - Private Methods
- (NSData *)jsonHttpBodyWithOffset:(int)offset andRange:(int)range {
    
    NSString *apiToken = [[[[NSBundle mainBundle] bundleIdentifier] reverse] MD5EncryptString];
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:
                         [NSNumber numberWithInt:range], @"range",
                         [NSNumber numberWithInt:offset], @"offset",
                          nil];
    
    NSDictionary *json = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"TributeMessages", @"method",
                          apiToken, @"api_token",
                          data, @"data",
                          nil];
    
    NSData *httpBody = [json JSONData];
    
    
    return httpBody;
    
}


#pragma mark - NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [connectionBuffer setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [connectionBuffer appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSDictionary *json = [connectionBuffer objectFromJSONData];
    
    for (NSDictionary *tributeJson in json) {
        
        YRTribute *tribute = [[YRTribute alloc] init];
        
        tribute.title = [tributeJson objectForKey:@"tribute_title"];
        tribute.author = [tributeJson objectForKey:@"tribute_author"];
        tribute.message = [tributeJson objectForKey:@"tribute_message"];
        tribute.device = [tributeJson objectForKey:@"tribute_device"];
        
        tribute.image = [NSURL URLWithString:[tributeJson objectForKey:@"tribute_image"]];
        //tribute.posted = [tributeJson objectForKey:@"tribute_posted"];
        
        tribute.flagged = [[tributeJson objectForKey:@"tribute_flagged"] boolValue];
        tribute.databaseRow = [[tributeJson objectForKey:@"tribute_database_row"] intValue];
        
        
        if (self.tributeObjects == nil)
            self.tributeObjects = [[NSMutableArray alloc] init];
        
        
        [self.tributeObjects addObject:tribute];
    }
    
    
    
    [delegate didFinishLoadingTributes:self.tributeObjects];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [delegate didFailLoadingTributes:error];
    
}


@end
