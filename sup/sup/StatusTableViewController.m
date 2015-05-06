//
//  ViewController.m
//  sup
//
//  Created by Sam Finegold on 3/2/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "StatusTableViewController.h"
#import "SupAPIManager.h"
//#import "MapViewController.h"
#import "SignUpViewController.h"

@interface StatusTableViewController ()
@end

@implementation StatusTableViewController
@synthesize table, statusData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.statusData = [[NSMutableArray alloc] init];
    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"statuses" options:NSKeyValueSetSetMutation context:nil];

//    self.statusData = [NSMutableArray arrayWithArray:[SupAPIManager getSharedInstance].statuses];
//    self.statusData = [[SupAPIManager getSharedInstance].statuses mutableCopy];
//    NSLog(@"Copied array: %@", self.statusData);
//    [table reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
    [[SupAPIManager getSharedInstance] loadStatuses];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"statuses"]){
        NSLog(@"Changes to this: %@", [SupAPIManager getSharedInstance].statuses);
        for (NSDictionary *status in [SupAPIManager getSharedInstance].statuses) {
            NSLog(@"status to add: %@", status);
            [self.statusData addObject:status];
        }
        NSLog(@"SupPosts: %@", statusData);
        [table reloadData];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return statusData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"status"];
//    NSLog(@"request DATA for CELL: %@", [self.statusData objectAtIndex:0]);
    cell.textLabel.text = [[self.statusData objectAtIndex:indexPath.row] valueForKey:@"owner_name"];
//    cell.detailTextLabel.text = [[self.statusData objectAtIndex:indexPath.row] valueForKey:@"duration"];
    return cell;
}

- (CGFloat)tableView:(UITableView*) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //if we want something to happen when we click on cells
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end