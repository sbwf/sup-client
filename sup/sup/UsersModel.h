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
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *location;

+(UsersModel*)getSharedInstance;
-(void)loadData;

@end
