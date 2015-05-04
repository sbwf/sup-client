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

//    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"friends" options:0 context:NULL];
    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"requests" options:0 context:NULL];
    
//    [[SupAPIManager getSharedInstance] loadFriends];
    [[SupAPIManager getSharedInstance] loadRequests];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"friends"]){
//        friendsData = [[NSArray alloc] initWithArray:[SupAPIManager getSharedInstance].friends];
//                NSLog(@"Friends Data: %@", friendsData);
//        [table reloadData];
//        NSLog(@"KVO reload friends");
//    }
    
    if ([keyPath isEqualToString:@"requests"]){
        requestsData = [[NSArray alloc] initWithArray:[SupAPIManager getSharedInstance].requests];

        NSLog(@"Requests Data: %@", requestsData);
        [self.tableView reloadData];
        NSLog(@"KVO reload requests");
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Num Requests: %zd", requestsData.count);
    return requestsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Making cell");
    UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"request"];
    
    NSLog(@"requess DATA for CELL: %@", [self.requestsData objectAtIndex:0]);
    NSLog(@"requess DATA for CELL: %@", [[self.requestsData objectAtIndex:0] valueForKey:@"user_id"]);
    cell.textLabel.text = [self.requestsData[indexPath.row][@"user_id"] description];
    cell.detailTextLabel.text = [self.requestsData[indexPath.row][@"created"] description];
    NSLog(@"after setting cell labels");
    return cell;
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
