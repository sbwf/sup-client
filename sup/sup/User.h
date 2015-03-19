//
//  User.h
//  sup
//
//  Created by Sam Finegold on 3/11/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsersModel.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic,strong) NSString *email;

@end


