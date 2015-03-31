//
//  CreateNewUserModel.m
//  sup
//
//  Created by Sam Finegold on 3/22/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "CreateNewUserModel.h"
#import "SignUp.h"
@implementation CreateNewUserModel

+ (CreateNewUserModel*)getSharedInstance{
    static CreateNewUserModel *instance;
    if (instance == nil)
        instance = [[CreateNewUserModel alloc] init];
    return instance;
}


-(void)addUser: (NSString*) name : (NSString*) email : (NSNumber*) user_id
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/users/"];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL:url];
    NSDictionary *userToAdd = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", name, @"name", user_id, @"id", nil];
    NSLog(@"%@", userToAdd);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userToAdd options:NSJSONWritingPrettyPrinted error:NULL];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:jsonData];
    
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             
             NSString *info = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
             NSLog(@"Message: %@", info);
         }
     }];
}


@end
