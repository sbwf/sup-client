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
                                       @"first_name" : firstName,
                                       @"last_name" : lastName,
                                       @"phone" : phoneNum
                                       };	
    

    [self makeRequest:@"POST" :@"/users/" :userToAdd withBlock:^(NSObject *data) {
        NSLog(@"did it!");
        NSLog(@"Data is: %@", data);
        self.myId = [data valueForKey:@"new_id"];
        NSLog(@"Setting my id %@", self.myId);
        done(self.myId);
    }];
    
}


- (void)postStatus:(CLLocation*)userLocation :(NSSet*)selectedFriends :(NSString*)message :(NSNumber*)duration withBlock:(void (^)(void))done{
    NSDictionary *statusToAdd = @{
                                          @"owner_id": self.myId,
                                          @"latitude" : @(userLocation.coordinate.latitude),
                                          @"longitude" : @(userLocation.coordinate.longitude),
                                          @"duration" : duration,
                                          @"message" : message
                                  };
    
    [self makeRequest:@"POST" :@"/status" :statusToAdd withBlock:^(NSObject *d) {
        NSLog(@"Posted status %@", d);
        done();
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

-(void)approveFriendRequest: (NSString*)requester_id {
    NSLog(@"approving a friend request");
    NSString *urlString = [NSString stringWithFormat:@"/users/%@/friends", requester_id];
    NSDictionary *friend_id = @{@"friend_id": (self.myId)};
    [self makeRequest:@"POST" :urlString :friend_id withBlock:^(NSObject *d) {
        NSLog(@"Approved a friend request %@", d);
        [self loadRequests];
    }];
}

-(void)requestFriend:(NSString *)friend_id {
    NSLog(@"making a friend request");
    NSString *urlString = [NSString stringWithFormat:@"/requests"];
    
    NSDictionary *rel = @{
                                  @"user_id": self.myId,
                                  @"requested_id" : friend_id,
                                  };
    
    [self makeRequestWithError:@"POST" :urlString :rel withBlock:^(NSObject *d) {
        NSLog(@"Posted status %@", d);
    }];
    
    
                           
}

-(void)searchForUser: (NSString*)phone withBlock:(void (^)(NSObject* d))done {
    NSString *urlString = [NSString stringWithFormat:@"/users?phone=%@", phone];
    
    [self makeRequestWithError:@"GET" :urlString :nil withBlock:^(NSObject *d) {
        NSDictionary *result = [[NSDictionary alloc]init];
        
        if ([d valueForKey:@"user"]) {
            result = [d valueForKey:@"user"];
        } else {
            NSLog(@"in else");
            NSString *errorMessage = [NSString stringWithFormat:@"We couldn't find a user with the phone number %@", phone];
            result = @{
                       @"error": errorMessage
                       };
        }
//        NSLog(@"finished searchForUser with result: %@", result);
        done(result);
    }];
}



//Generic http request utility function
- (void) makeRequest:(NSString *)method :(NSString *)urlPath :(NSDictionary *)dataObj withBlock:(void (^)(NSObject* d))block {
    
    // Change localhost to ip if testing on real device.
    NSString *urlString = [@"http://localhost:3000" stringByAppendingString:urlPath];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Make request obj with url and set request options
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL:url];
    req.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
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
                 NSHTTPURLResponse *httpRes = (NSHTTPURLResponse*) response;
                 NSLog(@"Error with request:"
                        "\n%@ %@"
                        "\nRequest headers: %@"
                        "\nRequest body: %@"
                        "\nResponse: %i"
                        "\nResponse headers: %@"
                        "\nResponse body: %@"
                        "\nError: %@",
                       req.HTTPMethod, req.URL,
                       req.allHTTPHeaderFields,
                       req.HTTPBody,
                       (int) httpRes.statusCode,
                       httpRes.allHeaderFields,
                       data,
                       error);
                 NSLog(@"body: %@", body);
             } else {
                 block(body);
             }
             
         } else {
             NSLog(@"Error on connection: %@", connectionError);
         }
     }];
}

//Generic http request utility function
- (void) makeRequestWithError:(NSString *)method :(NSString *)urlPath :(NSDictionary *)dataObj withBlock:(void (^)(NSObject* d))block {
    
    // Change localhost to ip if testing on real device.
    NSString *urlString = [@"http://localhost:3000" stringByAppendingString:urlPath];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Make request obj with url and set request options
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL:url];
    req.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
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
                 NSHTTPURLResponse *httpRes = (NSHTTPURLResponse*) response;
                 NSLog(@"Error with request:"
                       "\n%@ %@"
                       "\nRequest headers: %@"
                       "\nRequest body: %@"
                       "\nResponse: %i"
                       "\nResponse headers: %@"
                       "\nResponse body: %@"
                       "\nError: %@",
                       req.HTTPMethod, req.URL,
                       req.allHTTPHeaderFields,
                       req.HTTPBody,
                       (int) httpRes.statusCode,
                       httpRes.allHeaderFields,
                       data,
                       error);
//                 NSLog(@"body: %@", body);
                 
                 NSDictionary *errorJSON = @{
                                               @"error": error
                                               };
                 block(errorJSON);
             } else {
                 block(body);
             }
             
         } else {
             NSLog(@"Error on connection: %@", connectionError);
         }
     }];
}



@end
