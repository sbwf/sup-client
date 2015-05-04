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
@synthesize table, friendsData, requestsData;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Manage yo friends");
    
    //[SupAPIManager getSharedInstance].myId = @(2);
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

//        requestsData = [[NSDictionary alloc] in]
//        requestsData = [[NSDictionary alloc] initWithArray:[SupAPIManager getSharedInstance].requests];
        NSLog(@"Requests Data: %@", requestsData);
        [table reloadData];
        NSLog(@"KVO reload requests");
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"Num Requests: %zd", requestsData.count);
    return requestsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Making cell");
    static NSString *CellId = @"RequestCell";
    RequestCell *cell = (RequestCell*) [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:CellId owner:self options:nil];
        cell = [nib objectAtIndex:0];
        NSLog(@"Null cell");
    }
    
//    NSArray *requests = [[NSArray alloc]initWithArray:[requestsData objectForKey:@"friend_requests"]];
    NSLog(@"requess DATA for CELL: %@", [self.requestsData objectAtIndex:0]);
    NSLog(@"requess DATA for CELL: %@", [[self.requestsData objectAtIndex:0] valueForKey:@"user_id"]);
//    cell.userId.text = [NSString stringWithString:[[self.requestsData objectAtIndex:indexPath.row] valueForKey:@"user_id"]];
//    cell.requestedId.text = [NSString stringWithString:[[requestsData objectAtIndex:indexPath.row] objectForKey:@"requested_id"]];
    cell.created.text = [[requestsData objectAtIndex:indexPath.row] valueForKey:@"created"];
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
