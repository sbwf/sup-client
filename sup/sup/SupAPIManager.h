//
//  SupPost.h
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
@interface SupAPIManager : NSObject{
    UIAlertView *confirmPost;
}

@property (nonatomic, strong) NSMutableSet *statuses;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) NSArray *requests;
@property (nonatomic, strong) NSNumber *myId;

+(SupAPIManager*)getSharedInstance;

- (void)addUser: (NSString*)firstName :(NSString*)secondName :(NSString*)phoneNum withBlock:(void (^)(NSNumber* d))done;
- (void)loadStatuses;
- (void)loadFriends;
- (void)postStatus: (CLLocation*)userLocation :(NSSet*)selectedFriends :(NSString*)message :(NSNumber*)duration withBlock:(void (^)(void))done;
- (void)loadRequests;
- (void)approveFriendRequest: (NSString*)requester_id;
- (void)requestFriend: (NSString*)friend_id withBlock:(void (^)(NSObject* d))done;
- (void)searchForUser: (NSString*)phone withBlock:(void (^)(NSObject* d))done;
@end