//
//  UserData.m
//  GetDataTest
//
//  Created by Sam Finegold on 3/2/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "UsersModel.h"

@implementation UsersModel
@synthesize users;
static UsersModel *instance;

+ (UsersModel*)getSharedInstance{
    //static UserData *instance;
    if (instance == nil)
        instance = [[UsersModel alloc] init];
    return instance;
}

-(void)loadData{
    //Using tutorial: https://spring.io/guides/gs/consuming-rest-ios/
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/users/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             
             NSArray *info = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
             self.users = [[NSArray alloc]init];
             self.users = info;
         }
     }];
}

@end
