//
//  SupPost.m
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "SupPost.h"

@implementation SupPost

+ (SupPost*)getSharedInstance{
    static SupPost *instance;
    if (instance == nil)
        instance = [[SupPost alloc] init];
    return instance;
}

-(void)post{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/status/"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSDictionary *statusToAdd = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:399], @"owner", [NSNumber numberWithInt:89], @"Id", @"44.9392 , 93.1680", @"loc", [NSNumber numberWithInt:14], @"time", nil];
    NSLog(@"Status: %@", statusToAdd);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:statusToAdd options:NSJSONWritingPrettyPrinted error:NULL];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             
             NSString *info = [NSJSONSerialization JSONObjectWithData:data
                                                              options:0
                                                                error:NULL];
             NSLog(@"hi");
             NSLog(@"Post Status Message: %@", info);
         }
     }];
}
@end
