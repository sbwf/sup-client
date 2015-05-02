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
+(FriendManager*)getSharedInstance;

-(void)getAllFriends;
-(void)getFriendsOfUser: (NSInteger*) user_id;
-(void)getFriendRequestsForUser: (NSInteger*) user_id;
-(void)getLastStatusOfUser: (NSInteger*) user_id;

@end
