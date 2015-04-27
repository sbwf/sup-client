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

@property (nonatomic, strong) NSArray *supPosts;

+(SupAPIManager*)getSharedInstance;
-(void)loadStatuses;
-(void)postStatus: (CLLocation*) userLocation;
@end