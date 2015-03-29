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

-(void)startObserving{
    NSLog(@"in startobserving");
    [[SignUp getSharedInstance] addObserver:self forKeyPath:@"name" options:0 context:NULL];
    [[SignUp getSharedInstance] addObserver:self forKeyPath:@"email" options:0 context:NULL];
}

-(void)addUser{
    NSLog(@"ENTERED NAME: %@", [[SignUp getSharedInstance] getName]);
    NSLog(@"ENTERED Email: %@", [SignUp getSharedInstance].email);
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/users/"];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL:url];
    NSDictionary *userToAdd = [NSDictionary dictionaryWithObjectsAndKeys:@"Sam.finegold@aol.com", @"email", @"Sam", @"name", [NSNumber numberWithInt:1], @"id", nil];
    NSLog(@"%@", userToAdd);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userToAdd options:NSJSONWritingPrettyPrinted error:NULL];
    NSLog(@"Data: %@", jsonData);
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

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"name"]){
        NSLog(@"Observing for 'name'");
        NSLog(@"Users: %@", [SignUp getSharedInstance].name);
    }
    
}
@end
