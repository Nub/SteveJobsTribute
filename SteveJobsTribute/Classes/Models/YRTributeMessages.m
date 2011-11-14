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

#import "SVHTTPRequest.h"

@interface YRTributeMessages () 

- (NSDictionary *)tributeHttpParametersFromArray:(NSArray *)tributes;
- (NSDictionary *)tributeHttpParametersFromOffset:(NSInteger)offset withRange:(NSInteger)range;

@end


@implementation YRTributeMessages

@synthesize tributeObjects, delegate;



#pragma mark - Tributes from array
- (void)tributesFromArray:(NSArray *)tributes {
    
    NSDictionary *httpParameters = [self tributeHttpParametersFromArray:tributes];
    
    [SVHTTPRequest POST:@"http://tribute.frequenciesapp.com/api/v2/"
             parameters:httpParameters 
             completion:^(NSObject *response) {
                
                 NSLog(@"%@", response);
                 
                 /*NSMutableArray *tributeArrayObjects = [[NSMutableArray alloc] init];
                 
                 
                 for (NSDictionary *tributeJson in (NSDictionary *)response) {
                     
                     YRTribute *tribute = [[YRTribute alloc] init];
                     
                     tribute.mainText = [tributeJson objectForKey:@"mainText"];
                     tribute.author = [tributeJson objectForKey:@"author"];
                     tribute.header = [tributeJson objectForKey:@"header"];
                     tribute.location = [tributeJson objectForKey:@"location"];
                     
                     
                     tribute.databaseRow = [[tributeJson objectForKey:@"databaseRow"] intValue];
                     
    
                     
                     [tributeArrayObjects addObject:tribute];
                 }*/

                 
             }];
    
    
    
}


- (NSDictionary *)tributeHttpParametersFromArray:(NSArray *)tributes {
    
    NSMutableString *tributeString = [[NSMutableString alloc] init];
    NSString *apiToken = [[[[NSBundle mainBundle] bundleIdentifier] reverse] MD5EncryptString];
    
    /* Format Array */
    for (NSString *s in tributes)
        [tributeString appendString:[NSString stringWithFormat:@"%@|", s]];
    
    
    /* Remove the last 2 chars ", " */
    tributeString = (NSMutableString *)[tributeString substringFrom:0 to:[tributeString length]-1];
    
    
    
    NSDictionary *dataObject = [[NSDictionary alloc] initWithObjectsAndKeys:
                                tributeString, @"tributeArray", nil];
    
    NSDictionary *jsonObject = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"trbuteMessagesFromArray", @"method",
                                apiToken, @"api_token",
                                dataObject, @"data", nil];
    
    return jsonObject;
    
    
}



#pragma mark - Tributes from range
- (void)tributesFromOffset:(NSInteger)offset withRange:(NSInteger)range {
    
    NSDictionary *httpParameters = [self tributeHttpParametersFromOffset:offset withRange:range];
    
    
    //[self setTributeObjects:nil];
    // self.tributeObjects = [NSMutableArray array];
    
    [SVHTTPRequest POST:@"http://tribute.frequenciesapp.com/api/v2/"
             parameters:httpParameters 
             completion:^(NSObject *response) {
        
                 
                 for (NSDictionary *tributeJson in (NSDictionary *)response) {
                     
                     YRTribute *tribute = [[YRTribute alloc] init];
                     
                     tribute.mainText = [tributeJson objectForKey:@"mainText"];
                     tribute.author = [tributeJson objectForKey:@"author"];
                     tribute.header = [tributeJson objectForKey:@"header"];
                     tribute.location = [tributeJson objectForKey:@"location"];
                     
                     
                     tribute.databaseRow = [[tributeJson objectForKey:@"databaseRow"] intValue];
                     
                     
                     if (self.tributeObjects == nil)
                         self.tributeObjects = [[NSMutableArray alloc] init];
                     
                     
                     [self.tributeObjects addObject:tribute];
                 }
                 
                 
                 
                 [delegate didFinishLoadingTributes:self.tributeObjects];
             
             }];
    
}


- (NSDictionary *)tributeHttpParametersFromOffset:(NSInteger)offset withRange:(NSInteger)range {
      
    NSString *apiToken = [[[[NSBundle mainBundle] bundleIdentifier] reverse] MD5EncryptString];
         
    NSDictionary *dataObject = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSNumber numberWithInteger:offset], @"offset",
                                [NSNumber numberWithInteger:range], @"range", nil];
    
    NSDictionary *jsonObject = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"trbuteMessagesFromRange", @"method",
                                apiToken, @"api_token",
                                dataObject, @"data", nil];
    
    return jsonObject;
    
}
     
     


/*- (void)tributeMessagesFromOffset:(int)offset withRange:(int)range {

    
    
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
                          @"trbuteMessagesFromRange", @"method",
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
    if (json == nil)
        return;
    
    
    for (NSDictionary *tributeJson in json) {
        
        YRTribute *tribute = [[YRTribute alloc] init];
        
        tribute.mainText = [tributeJson objectForKey:@"mainText"];
        tribute.author = [tributeJson objectForKey:@"author"];
        tribute.header = [tributeJson objectForKey:@"header"];
        tribute.location = [tributeJson objectForKey:@"location"];
        
        
        tribute.databaseRow = [[tributeJson objectForKey:@"databaseRow"] intValue];
        
        
        if (self.tributeObjects == nil)
            self.tributeObjects = [[NSMutableArray alloc] init];
        
        
        [self.tributeObjects addObject:tribute];
    }
    
    
    
    [delegate didFinishLoadingTributes:self.tributeObjects];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [delegate didFailLoadingTributes:error];
    
}
*/

@end
