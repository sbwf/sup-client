//
//  SupPost.m
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "SupAPIManager.h"
#import "MapViewController.h"

@implementation SupAPIManager
@synthesize friends, statuses;

+ (SupAPIManager*)getSharedInstance{
    static SupAPIManager *instance;
    if (instance == nil) {
        instance = [[SupAPIManager alloc] init];
        instance.statuses = [[NSMutableSet alloc] init];
    }
    return instance;
}


- (void)addUser: (NSString*) firstName : (NSString*) lastName : (NSString*) phoneNum {
    NSDictionary *userToAdd =@{
                               @"user" :
                                   @{
                                       @"first_name" : firstName,
                                       @"last_name" : lastName,
                                       @"phone" : phoneNum
                                       }
                               };
    
    [self makeRequest:@"POST" :@"/users/" :userToAdd withBlock:^(NSObject *data) {
        NSLog(@"did it!");
        NSLog(@"Data is: %@", data);
    }];
    
}

-(void)loadStatuses{
    NSLog(@"In 'loadStatuses'");
    [self makeRequest:@"GET" :@"/status" :nil withBlock:^(NSObject *d) {
        // For each new status, make marker and add to set
//        NSLog(@"Data: %@", d);
//        NSArray *statusArray = [[NSArray alloc] initWithArray:[d valueForKey:@"statuses"]];
//        NSLog(@"My statuses: %@", self.statuses);
        for (NSDictionary *status in [d valueForKey:@"statuses"]) {
//            NSLog(@"Adding dict %@", status);
            [self.statuses addObject:status];
        }
//        NSLog(@"My statuses: %@", self.statuses);
    }];
}

-(void)postStatus: (CLLocation*) userLocation{
    NSLog(@"LATITUDE %f@", userLocation.coordinate.latitude);
    NSLog(@"LONGITUDE %f@", userLocation.coordinate.longitude);

    NSDictionary *statusToAdd = @{
                                  @"status":
                                      @{
                                          @"owner_id": @(1),
                                          @"latitude" : @(userLocation.coordinate.latitude),
                                          @"longitude" : @(userLocation.coordinate.longitude),
                                          }
                                  };
    
    [self makeRequest:@"POST" :@"/status" :statusToAdd withBlock:^(NSObject *d) {
        NSLog(@"Posted status %@", d);
        [MapViewController getSharedInstance].myMarker = [[MapViewController getSharedInstance] makeMarker:userLocation.coordinate.latitude :userLocation.coordinate.longitude :@"Scott"];
        
    }];
}


//Generic http request utility function
- (void) makeRequest:(NSString *)method :(NSString *)urlPath :(NSDictionary *)data withBlock:(void (^)(NSObject* d))block {
    
    // Change localhost to ip if testing on real device.
    NSString *urlString = [@"http://localhost:3000" stringByAppendingString:urlPath];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Make request obj with url and set request options
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL:url];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    if ([method isEqualToString:@"POST"])  {
        //Perpare data for req. JSON
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                           options:NSJSONWritingPrettyPrinted error:NULL];
        [req setHTTPBody:jsonData];
        [req setHTTPMethod:@"POST"];
    }
    
    if ([method isEqualToString:@"GET"]) {
        [req setHTTPMethod:@"GET"];
    }
    
    
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil) {
             NSDictionary *body = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSString *error = [body valueForKey:@"error"];
             
             if (error) {
                 NSLog(@"Error: %@", error);
                 NSLog(@"body: %@", body);
             } else {
                 block(body);
             }
             
         } else {
             NSLog(@"Error on connection: %@", connectionError);
         }
     }];
}


@end
