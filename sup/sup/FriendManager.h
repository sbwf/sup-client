//
//  FriendManager.h
//  sup
//
//  Created by Sam Finegold on 4/12/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FriendManager : NSObject

@property (nonatomic, strong) NSDictionary *allFriendships;
@property (nonatomic, strong) NSDictionary *friends;
@property (nonatomic, strong) NSDictionary *requests;
+(FriendManager*)getSharedInstance;

-(void)getAllFriends;
-(void)getFriendsOfUser: (NSInteger*) user_id;
-(void)getFriendRequestsForUser: (NSInteger*) user_id;
-(void)getLastStatusOfUser: (NSInteger*) user_id;
-(void)searchForUserByphone: (NSString*) phone_number;
-(void)requestUser:(NSInteger*) user_id reqId:(NSInteger*) requested_id;
-(void)approveRequest:(NSInteger*) user_id friendId:(NSInteger*) friend_id;
-(void)deleteFriend:(NSInteger*) user_id friendId:(NSInteger*) friend_id;

@end
