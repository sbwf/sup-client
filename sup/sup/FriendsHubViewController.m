//
//  FriendsHubViewController.m
//  sup
//
//  Created by Sam Finegold on 4/15/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "FriendsHubViewController.h"
#import "FriendManager.h"

@interface FriendsHubViewController ()

@end

@implementation FriendsHubViewController
@synthesize table1, table2, friendData, friends, requestData, requests;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [[FriendManager getSharedInstance] addObserver:self forKeyPath:@"friends" options:0 context:NULL];
    [[FriendManager getSharedInstance] getFriendsOfUser:(NSInteger *) 2];
    
//  friends generates an error when this gets uncommented?
//    [[FriendManager getSharedInstance] addObserver:self forKeyPath:@"requests" options:0 context:NULL];
//    [[FriendManager getSharedInstance] getFriendRequestsForUser:(NSInteger *) 2];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"friends"]){
        NSLog(@"here- friends");
        friendData = [[NSDictionary alloc]initWithDictionary:[FriendManager getSharedInstance].friends];
        NSLog(@"Friends: %@", friendData);
        [table2 reloadData];
        NSLog(@"after reload friendData");
    }
    
    if ([keyPath isEqualToString:@"requests"]){
        NSLog(@"here- requests");
        requestData = [[NSDictionary alloc]initWithDictionary:[FriendManager getSharedInstance].requests];
        NSLog(@"Requests: %@", requestData);
        [table1 reloadData];
        NSLog(@"after reload requestData");
    }
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return friendData.count + requestData.count + 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"In cell for row at index path");
    static NSString *friendCellId = @"FriendCell";
    FriendCell *friendCell = (FriendCell*) [tableView dequeueReusableCellWithIdentifier:friendCellId];
    
    static NSString *requestCellId = @"RequestCell";
    RequestCell *requestCell = (RequestCell*) [tableView dequeueReusableCellWithIdentifier:requestCellId];
    
    if (friendCell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:friendCellId owner:self options:nil];
        friendCell = [nib objectAtIndex:0];
    }
    
    if (requestCell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:requestCellId owner:self options:nil];
        requestCell = [nib objectAtIndex:0];
    }
    
    if (indexPath.section == 1) {
        NSLog(@"HERE: %@", friends);
        NSLog(@"%@",[NSString stringWithFormat:@"Owner: %@", [[[friends objectAtIndex:indexPath.row] objectForKey:@"user_id"] stringValue]]);
        friends = [[NSArray alloc]initWithArray:[friendData objectForKey:@"friends"]];
        friendCell.firstName.text = [NSString stringWithFormat:@"First name: %@", [[[friends objectAtIndex:indexPath.row] objectForKey:@"first_name"] stringValue]];
        friendCell.lastName.text = [NSString stringWithFormat:@"Last name: %@", [[friends objectAtIndex:indexPath.row] objectForKey:@"last_name"]];
        //    cell.lastActive.text = [NSString stringWithFormat:@"Latitude: %@", [[[friends objectAtIndex:indexPath.row] objectForKey:@"xxx"] stringValue]];
        
    } else {
        NSLog(@"HERE: %@", requests);
        NSLog(@"%@",[NSString stringWithFormat:@"Owner: %@", [[[requests objectAtIndex:indexPath.row] objectForKey:@"user_id"] stringValue]]);
        requests = [[NSArray alloc]initWithArray:[requestData objectForKey:@"requests"]];
        requestCell.requester_id.text = [NSString stringWithFormat:@"Requester ID: %@", [[[requests objectAtIndex:indexPath.row] objectForKey:@"user_id"] stringValue]];
        requestCell.requested_id.text = [NSString stringWithFormat:@"Requested ID: %@", [[requests objectAtIndex:indexPath.row] objectForKey:@"requested_id"]];
        requestCell.requestedAt.text = [NSString stringWithFormat:@"Requested at: %@", [[[requests objectAtIndex:indexPath.row] objectForKey:@"created"] stringValue]];
        
    }
    
    
//    [[[friends objectAtIndex:indexPath.row] objectForKey:@"latitude"] stringValue];
    NSLog(@"after setting cell labels");
    return friendCell;
}

-(CGFloat)tableView:(UITableView*) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //if we want something to happen when we click on cells
}




//  /////////boilerplate

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
