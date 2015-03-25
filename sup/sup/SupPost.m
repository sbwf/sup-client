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

-(void)post{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/status/"];
    NSMutableURLRequest *rq = [[NSMutableURLRequest alloc]initWithURL:url];
    //NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    NSString *name = @"Sam";
    
    [rq setHTTPMethod:@"POST"];
    [rq setValue:@"applciation/json" forHTTPHeaderField:@"Content-type"];
    [rq setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[name length]] forHTTPHeaderField:@"Content-length"];
    [rq setHTTPBody:[name dataUsingEncoding:NSUTF8StringEncoding]];
    [[NSURLConnection alloc]initWithRequest:rq delegate:self];
    
    /*
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSData *jsonData = [@"{ \"foo\": 1337 }" dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"JSON DATA: %@", jsonData);
    [rq setHTTPBody:jsonData];
    [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [NSURLConnection sendAsynchronousRequest:rq queue:queue completionHandler:^(NSURLResponse *rsp, NSData *data, NSError*err){
        NSLog(@"POST SENT!");
    }];
     */
}
@end
