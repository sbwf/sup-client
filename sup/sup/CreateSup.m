//
//  CreateSup.m
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "CreateSup.h"
#import <GoogleMaps/GoogleMaps.h>
@interface CreateSup ()

@end

@implementation CreateSup
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)post{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/status/"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSDictionary *statusToAdd = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:399], @"owner", [NSNumber numberWithInt:89], @"Id", [NSNumber numberWithFloat:44.934310], @"latitude", [NSNumber numberWithFloat:-93.167929], @"longitude", [NSNumber numberWithInt:14], @"time", nil];
    NSLog(@"Status: %@", statusToAdd);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:statusToAdd options:NSJSONWritingPrettyPrinted error:NULL];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             
             NSString *info = [NSJSONSerialization JSONObjectWithData:data
                                                              options:0
                                                                error:NULL];
             NSLog(@"hi");
             NSLog(@"Post Status Message: %@", info);
         }
     }];
}

-(IBAction)postedSup:(id)sender{
    [self post];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
