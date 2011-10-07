//
//  YRTributeCollector.m
//  SteveJobsTribute
//
//  Created by Jack Perry on 7/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "YRTributeCollector.h"

#import "JSONKit.h"
#import "YRTribute.h"
#import "NSString+Additions.h"


@interface YRTributeCollector () {
@private
    NSMutableData       *connectionBuffer;
    
}

- (NSData *)generateJSONBody;

@end


@implementation YRTributeCollector
@synthesize tributeObjects;


- (id)init {
    
    self = [super init];
    
    return self;
}


- (void)collectTributes {
    
    NSData *JSONBody = [self generateJSONBody];
    
    NSURL *tributeAPIURL = [NSURL URLWithString:@"http://api.frequenciesapp.com/NEW/"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:tributeAPIURL];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:JSONBody];
    
    if (connectionBuffer == nil)
        connectionBuffer = [[NSMutableData alloc] init];
    
    NSURLConnection *tributeUrlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [tributeUrlConnection start];
    
}



#pragma mark - Private Methods
- (NSData *)generateJSONBody {
    
    NSString *apiKey = [[[[NSBundle mainBundle] bundleIdentifier] reverse] MD5EncryptString];
    
    NSDictionary *jsonDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    apiKey, @"APIKey",
                                    @"YRListTributes", @"Action",
                                    @"", @"Data",
                                    nil];
    
    NSData *jsonData = [jsonDictionary JSONData];
    
    NSString *jsonDataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonData;
}



#pragma mark - NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [connectionBuffer setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [connectionBuffer appendData:data];
    
}
                                                            
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    NSString *connectionBufferString = [[NSString alloc] initWithData:connectionBuffer encoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDictionary = [connectionBuffer objectFromJSONData];
    
    for (int i = 1; i <= [jsonDictionary count]; i++) {
        
        NSDictionary *tributeDicitionary = [jsonDictionary objectForKey:[NSString stringWithFormat:@"%d", i]];
        
        YRTribute *tribute = [[YRTribute alloc] initWithDictionary:tributeDicitionary];
        
        if (tributeObjects == nil)
            tributeObjects = [[NSMutableArray alloc] init];
        
        [tributeObjects addObject:tribute];
        
        NSLog(@"Tribute %@, by %@.", tribute.title, tribute.author);
        
    }
    
    /* Delegeate call should be done here */
    
}


@end
