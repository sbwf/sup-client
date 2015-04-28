//
//  SupPost.m
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "SupAPIManager.h"
    @implementation SupAPIManager

+ (SupAPIManager*)getSharedInstance{
    static SupAPIManager *instance;
    if (instance == nil)
        instance = [[SupAPIManager alloc] init];
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
             
             NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
             self.statuses = [[NSDictionary alloc]init];
             self.statuses = info;
             NSLog(@"Got Statuses");
             NSLog(@"Statuses: %@", self.statuses);
         }
     }];
}

-(void)postStatus: (CLLocation*) userLocation{
    NSLog(@"in post status");
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/status/"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    //TODO: ask scott about captialized Id
    NSDictionary *statusToAdd = @{
                                  @"status":
  @{
        @"owner_id": @(1),
        @"latitude" : @(userLocation.coordinate.latitude),
        @"longitude" : @(userLocation.coordinate.longitude),
    }};
    
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
             //TODO: notification for when it's done
         }
     }];
}

-(void)addUser: (NSString*) name : (NSString*) email : (NSNumber*) user_id
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/users/"];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL:url];
    
    NSDictionary *userToAdd =@{
                               @"user" :
                                   @{
                                       @"email" : email,
                                       @"name" : name,
                                       @"id" : user_id
                                       }
                               };
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userToAdd
                                                       options:NSJSONWritingPrettyPrinted error:NULL];
    
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:jsonData];
    
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             
             NSString *info = [NSJSONSerialization JSONObjectWithData:data
                                                              options:0
                                                                error:NULL];
             NSLog(@"Message: %@", info);
         }
     }];
}

@end
