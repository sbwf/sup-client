//
//  FriendManager.m
//  sup
//
//  Created by Sam Finegold on 4/12/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "FriendManager.h"

@implementation FriendManager

+ (FriendManager*)getSharedInstance{
    static FriendManager *instance;
    if (instance == nil)
        instance = [[FriendManager alloc] init];
    return instance;
}

-(void)getAllFriends{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/friends"];
    NSLog(@"In 'getAllFriends'");
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
             self.allFriendships = [[NSDictionary alloc]init];
             self.allFriendships = info;
             NSLog(@"All Friendships: %@", self.allFriendships);
         }
     }];
}

-(void)getFriendsOfUser:(NSInteger *)user_id{
//    NSString *urlStem = @"http://localhost:3000/users/";
//    NSString *urlEnd = @"/friends";
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/users/2/friends"];
//    NSURL *finalUrl = [NSString stringWithFormat:@"%@%ld%@", urlStem, user_id, urlEnd];
    
    NSLog(@"In 'getFriendsOfUser'");
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
             self.friends = [[NSDictionary alloc]init];
             self.friends = info;
             NSLog(@"Friends: %@", self.friends);
         }
     }];

}

-(void)getFriendRequestsForUser:(NSInteger *)user_id{
    NSLog(@"In 'getFriendRequestsForUser - not implemented yet'");
    //    NSString *urlStem = @"http://localhost:3000/users/";
    //    NSString *urlEnd = @"/friends";
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/requests/2"];
    //    NSURL *finalUrl = [NSString stringWithFormat:@"%@%ld%@", urlStem, user_id, urlEnd];
    
    NSLog(@"In 'getFriendRequestsForUser'");
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
             self.requests = [[NSDictionary alloc]init];
             self.requests = info;
             NSLog(@"Friend requests: %@", self.requests);
         }
     }];
    
}

-(void)getLastStatusOfUser:(NSInteger *)user_id{
    NSLog(@"In 'getLastStatusOfUser - not implemented yet'");
    
}

-(void)searchForUserByphone:(NSString *)phone_number{
    NSString *urlStem = @"http://localhost:3000/users/?phone=";
    NSURL *url = [NSString stringWithFormat:@"%@%@", urlStem, phone_number];
    NSLog(@"%@", url);
    
}

-(void)requestUser:(NSInteger *)user_id reqId:(NSInteger *)requested_id {
    NSLog(@"In 'rqeuestUser'; userID: %ld reqId: %ld", user_id, requested_id);
}

-(void)approveRequest:(NSInteger *)user_id friendId:(NSInteger *)friend_id {
    NSLog(@"In 'approveRequest'; userID: %ld friendId: %ld", user_id, friend_id);

}

-(void)deleteFriend:(NSInteger *)user_id friendId:(NSInteger *)friend_id {
    NSLog(@"In 'deleteFriend'; userID: %ld friendId: %ld", user_id, friend_id);

}




@end
