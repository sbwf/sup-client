//
//  SupPost.h
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupPost : NSObject
@property (nonatomic, strong) NSArray *supPosts;
+(SupPost*)getSharedInstance;
-(void)post;
@end
