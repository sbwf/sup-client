//
//  SupPost.m
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "SupPost.h"

@implementation SupPost

+ (SupPost*)getSharedInstance{
    static SupPost *instance;
    if (instance == nil)
        instance = [[SupPost alloc] init];
    return instance;
}

-(void)loadStatuses{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/status/"];
    NSLog(@"IN SUP POST");
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
             self.supPosts = [[NSArray alloc]init];
             self.supPosts = info;
         }
     }];
}
@end
