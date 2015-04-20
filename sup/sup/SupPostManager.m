//
//  SupPost.m
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "SupPostManager.h"
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

-(void)postStatus: (CLLocation*) userLocation{
    NSLog(@"in post status");
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/status/"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    //TODO: ask scott about captialized Id
    NSDictionary *statusToAdd = @{
        @"Owner": @(1),
        @"Id" : @(89),
        @"latitude" : @(userLocation.coordinate.latitude),
        @"longitude" : @(userLocation.coordinate.longitude),
        @"time" : @(14)
    };
    
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
             //What happens when it doesn't succeed...we're assuming it's going to succeed. if succeeds, add
             NSString *info = [NSJSONSerialization JSONObjectWithData:data
                                                              options:0
                                                                error:NULL];
             confirmPost =[[UIAlertView alloc]initWithTitle:@"Post Success"
                                                      message:@"You've posted a SUP!"
                                                     delegate:self
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles:nil];
             
             [confirmPost show];
             //TODO: notification for when it's done
         }
     }];
}

@end
