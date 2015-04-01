//
//  SupPost.h
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupPostManager : NSObject
@property (nonatomic, strong) NSArray *supPosts;
@property (nonatomic) BOOL *postedSup;
+(SupPostManager*)getSharedInstance;
-(void)loadStatuses;
-(void)postStatus;
@end