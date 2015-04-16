//
//  UserData.h
//  GetDataTest
//
//  Created by Sam Finegold on 3/2/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsersModel : NSObject{
}
@property (nonatomic,strong) NSArray *users;
@property (nonatomic, strong) NSArray *usersFriends;

+(UsersModel*)getSharedInstance;
-(void)loadData;
-(void)getFriendsOfUser;
-(void)addFriend;

@end