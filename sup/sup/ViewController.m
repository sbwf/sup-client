//
//  ViewController.m
//  sup
//
//  Created by Sam Finegold on 3/2/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "ViewController.h"
#import "UsersModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UsersModel getSharedInstance] addObserver:self forKeyPath:@"users" options:0 context:NULL];
    [[UsersModel getSharedInstance] loadData];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"users"]){
        NSLog(@"Observing for 'users'");
        NSLog(@"Users: %@", [UsersModel getSharedInstance].users);
        NSArray *users = [UsersModel getSharedInstance].users;
        for (NSDictionary *user in users){
            NSString *name = [user objectForKey:@"name"];
            NSLog(@"Name: %@", name);
            _userName.text = name;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end