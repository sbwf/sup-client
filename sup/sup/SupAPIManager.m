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
//        instance.myId = @(1); //Hard coding
    }
    return instance;
}


- (void)addUser:(NSString*)firstName :(NSString*)lastName :(NSString*)phoneNum withBlock:(void (^)(NSNumber* d))done {
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
//        self.myId = [[NSNumber alloc]init];
        self.myId = [data valueForKey:@"new_id"];
        NSLog(@"Setting my id %@", self.myId);
        done(self.myId);
    }];
    
}


- (void)postStatus:(CLLocation*)userLocation :(NSSet*)selectedFriends :(NSNumber*)duration{
    NSLog(@"LATITUDE %f", userLocation.coordinate.latitude);
    NSLog(@"LONGITUDE %f", userLocation.coordinate.longitude);
    NSLog(@"MY ID %@", self.myId);
    NSLog(@"MY DURATION %@", duration);
    NSDictionary *statusToAdd = @{
                                          @"owner_id": self.myId,
                                          @"latitude" : @(userLocation.coordinate.latitude),
                                          @"longitude" : @(userLocation.coordinate.longitude),
                                          @"duration" : duration
                                  };
    
    [self makeRequest:@"POST" :@"/status" :statusToAdd withBlock:^(NSObject *d) {
        NSLog(@"Posted status %@", d);
        
        //TODO: Take out line of code below and see if it still works.
        [[MapViewController getSharedInstance].statusMarkers addObject:[[MapViewController getSharedInstance] makeMarker:userLocation.coordinate.latitude :userLocation.coordinate.longitude :@"sam" : self.myId]];
        
    }];
}


- (void)loadStatuses {
    NSLog(@"In 'loadStatuses'");
    NSString *urlString = [NSString stringWithFormat:@"/users/%@/visible", self.myId];
    [self makeRequest:@"GET" :urlString :nil withBlock:^(NSObject *d) {
        // For each new status, make marker and add to set
        for (NSDictionary *status in [d valueForKey:@"statuses"]) {
            [self.statuses addObject:status];
        }
    }];
}


- (void)loadFriends {
    NSLog(@"getting friends from server");
    NSString *urlString = [NSString stringWithFormat:@"/users/%@/friends", self.myId];
    NSLog(@"url string: %@", urlString);
    [self makeRequest:@"GET" :urlString :nil withBlock:^(NSObject *d) {
        NSLog(@"Got friends!");
        self.friends = [d valueForKey:@"friends"];
        NSLog(@"Friends array: %@", self.friends);
    }];
}


- (void) loadRequests {
    NSLog(@"getting friend requests from server");
    NSString *urlString = [NSString stringWithFormat:@"/requests/%@", self.myId];
    [self makeRequest:@"GET" :urlString :nil withBlock:^(NSObject *d) {
        NSLog(@"Got requests!");
//        self.requests = [NSArray arrayWithObject:[d valueForKey:@"pending_requests"]];
        self.requests = [d valueForKey:@"pending_requests"];
//        NSLog(@"Requests array: %@", self.requests);
    }];
    
}

//-(void)approveFriendRequest: (NSInteger*)requester_id {
//    NSLog(@"approving a friend request");
//    NSString *urlString = [NSString stringWithFormat:@"/users/%@/friends", requester_id];
//    NSDictionary *friend_id = @{@"friend_id": (self.myId)};
//    [self makeRequest:@"POST" :urlString :friend_id withBlock:^(NSDictionary *d) {
//        NSLog(@"Approved a friend request %@", d);
//    }];
//}



//Generic http request utility function
- (void) makeRequest:(NSString *)method :(NSString *)urlPath :(NSDictionary *)dataObj withBlock:(void (^)(NSObject* d))block {
    
    // Change localhost to ip if testing on real device.
    NSString *urlString = [@"http://localhost:3000" stringByAppendingString:urlPath];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Make request obj with url and set request options
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL:url];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    if ([method isEqualToString:@"POST"])  {
        //Perpare data for req. JSON
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dataObj
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
                 NSLog(@"Error with request to %@: %@", urlString, error);
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
