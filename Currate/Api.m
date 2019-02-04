//
//  Api.m
//  Currate
//
//  Created by Eugene Vegner on 2/4/19.
//  Copyright © 2019 Eugene Vegner. All rights reserved.
//

#import "Api.h"
static NSString * const kBaseUrl = @"https://currate.ru";
static NSString * const kApiKey = @"dbc0a80dc45a23d1a68ecce161d99fe8";

@implementation Api

- (void)getMethod:(NSString *)method withParameters:(nullable NSDictionary *)params success:(SuccessBlock)block {
    
    NSURL *url = [NSURL URLWithString:kBaseUrl];
    NSURLComponents *components = [NSURLComponents componentsWithURL:url
                                             resolvingAgainstBaseURL:NO];
    [components setPath:@"/api/"];
    
    NSMutableArray<NSURLQueryItem*> *queryItems =
    [NSMutableArray arrayWithObjects:
     [NSURLQueryItem queryItemWithName:@"get" value:method],
     [NSURLQueryItem queryItemWithName:@"key" value:kApiKey], nil];
    
    if (params) {
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSURLQueryItem *qi = [NSURLQueryItem queryItemWithName:key value:obj];
            [queryItems addObject:qi];
        }];
    }
    
#ifdef DEBUG
    NSLog(@"QueryItems: %@",queryItems);
#endif
    [components setQueryItems:queryItems];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
#ifdef DEBUG
    NSLog(@"URL: %@",components.URL);
#endif
    if (components.URL == nil) {
        block(nil);
        return;
    }
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:components.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSError* parseError;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&parseError];
        
#ifdef DEBUG
        NSLog(@"Error: %@",error);
        NSLog(@"Parse Error: %@",parseError);
        NSLog(@"json: %@",json);
#endif

        block(json);
    }];
    [task resume];
}

@end
