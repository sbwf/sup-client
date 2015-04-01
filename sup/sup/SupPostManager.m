//
//  SupPost.m
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "SupPostManager.h"
#import "CreateSup.h"
@implementation SupPostManager

+ (SupPostManager*)getSharedInstance{
    static SupPostManager *instance;
    if (instance == nil)
        instance = [[SupPostManager alloc] init];
    return instance;
}

-(void)loadStatuses{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/status/"];
    NSLog(@"In 'loadStatuses'");
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             
             NSArray *info = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
             self.supPosts = [[NSArray alloc]init];
             self.supPosts = info;
         }
     }];
}

-(void)postStatus{
    _postedSup = false;
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/status/"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    //Dupre: 44.941099, -93.167876
    //Broiler 44.934105, -93.167368
    NSDictionary *statusToAdd = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:5524716], @"owner", [NSNumber numberWithInt:89], @"Id", [NSNumber numberWithFloat:44.934105], @"latitude", [NSNumber numberWithFloat: -93.167368], @"longitude", [NSNumber numberWithInt:14], @"time", nil];
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
             _postedSup = true;
         }
     }];
}

@end
