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

@property (nonatomic, strong) NSDictionary *statuses;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) NSArray *requests;
@property (nonatomic, strong) NSNumber *myId;

+(SupAPIManager*)getSharedInstance;

-(void)addUser: (NSString*) firstName : (NSString*) secondName : (NSString*) phoneNum;
-(void)loadStatuses;
-(void)loadFriends;
-(void)postStatus: (CLLocation*)userLocation :(NSSet*)selectedFriends;
-(void)loadRequests;
//-(void)approveFriendRequest: (NSInteger*)requester_id;
@end