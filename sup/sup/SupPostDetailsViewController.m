//
//  SupPostDetailsViewController.m
//  sup
//
//  Created by Sam Finegold on 4/15/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "SupPostDetailsViewController.h"

@interface SupPostDetailsViewController ()

@end

@implementation SupPostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (SupPostDetailsViewController*)getSharedInstance{
    static SupPostDetailsViewController *instance;
    if (instance == nil)
        instance = [[SupPostDetailsViewController alloc] init];
    return instance;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
