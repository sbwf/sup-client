//
//  FriendsHubViewController.m
//  sup
//
//  Created by Sam Finegold on 4/15/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "FriendsHubViewController.h"
#import "SupAPIManager.h"


@interface FriendsHubViewController ()

@end

@implementation FriendsHubViewController
@synthesize friendsData, requestsData;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Manage yo friends");
    
    [SupAPIManager getSharedInstance].myId = @(2);
    NSLog(@"My Id is: %@", [SupAPIManager getSharedInstance].myId);

    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"friends" options:NSKeyValueObservingOptionInitial context:NULL];
    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"requests" options:NSKeyValueObservingOptionInitial context:NULL];
    
    [[SupAPIManager getSharedInstance] loadFriends];
    [[SupAPIManager getSharedInstance] loadRequests];
}

- (void)dealloc {
    [[SupAPIManager getSharedInstance] removeObserver:self forKeyPath:@"friends"];
    [[SupAPIManager getSharedInstance] removeObserver:self forKeyPath:@"requests"];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"-------> in observeValue, KVO path %@", keyPath);
    
    if ([keyPath isEqualToString:@"friends"]){
        friendsData = [[NSArray alloc] initWithArray:[SupAPIManager getSharedInstance].friends];
        NSLog(@"Friends Data: %@", friendsData);
        [self.tableView reloadData];
        NSLog(@"KVO reload friends");
    }
    
    if ([keyPath isEqualToString:@"requests"]){
        requestsData = [[NSArray alloc] initWithArray:[SupAPIManager getSharedInstance].requests];

        NSLog(@"Requests Data: %@", requestsData);
        [self.tableView reloadData];
        NSLog(@"KVO reload requests");
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Add Friends";
    } else if (section == 1) {
        return @"Pending Requests";
    } else {
        return @"Friends";
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        NSLog(@"Num Requests: %zd", requestsData.count);
        return requestsData.count;
    } else {
        NSLog(@"Num friends: %zd", friendsData.count);
        return friendsData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"making search cell");
        UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"add"];
        return cell;
    } else if (indexPath.section == 1) {
        NSLog(@"Making request cell");
        UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"request"];
        
        NSLog(@"request DATA for CELL: %@", [self.requestsData objectAtIndex:0]);
        cell.textLabel.text = [self.requestsData[indexPath.row][@"user_name"] description];
        cell.detailTextLabel.text = [self.requestsData[indexPath.row][@"created"] description];
        NSLog(@"after setting request cell labels");
        return cell;
    } else {
        NSLog(@"Making friend cell");
        UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"friend"];
        NSLog(@"friend DATA for CELL: %@", [self.friendsData objectAtIndex:0]);
        cell.textLabel.text = [self.friendsData[indexPath.row][@"first_name"] description];
        cell.detailTextLabel.text = [self.friendsData[indexPath.row][@"last_name"] description];
        NSLog(@"after setting friend cell labels");
        return cell;

        
    }
    

}












//  boilerplate

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
