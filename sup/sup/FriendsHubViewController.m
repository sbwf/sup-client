//
//  FriendsHubViewController.m
//  sup
//
//  Created by Sam Finegold on 4/15/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "FriendsHubViewController.h"
#import "SupAPIManager.h"
#import "YLMoment.h"


@interface FriendsHubViewController ()

@end

@implementation FriendsHubViewController
@synthesize friendsData, requestsData;


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"Manage yo friends");
    NSLog(@"My Id is: %@", [SupAPIManager getSharedInstance].myId);

    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"friends" options:NSKeyValueObservingOptionInitial context:NULL];
    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"requests" options:NSKeyValueObservingOptionInitial context:NULL];
    
    [[SupAPIManager getSharedInstance] loadFriends];
    [[SupAPIManager getSharedInstance] loadRequests];
}

//  remove keyObservers onleave
- (void)dealloc {
    [[SupAPIManager getSharedInstance] removeObserver:self forKeyPath:@"friends"];
    [[SupAPIManager getSharedInstance] removeObserver:self forKeyPath:@"requests"];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    NSLog(@"-------> in observeValue, KVO path %@", keyPath);
    
    if ([keyPath isEqualToString:@"friends"]){
        friendsData = [[NSArray alloc] initWithArray:[SupAPIManager getSharedInstance].friends];
//        NSLog(@"Friends Data: %@", friendsData);
        [self.tableView reloadData];
//        NSLog(@"KVO reload friends");
    }
    
    if ([keyPath isEqualToString:@"requests"]){
        requestsData = [[NSArray alloc] initWithArray:[SupAPIManager getSharedInstance].requests];

//        NSLog(@"Requests Data: %@", requestsData);
        [self.tableView reloadData];
//        NSLog(@"KVO reload requests");
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Follower Requests";
    } else if (section == 1) {
        return @"Following";
    } else {
        return @"Unmarked section";
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
//        NSLog(@"Num Requests: %zd", requestsData.count);
        
        return requestsData.count;
    } else {
//        NSLog(@"Num friends: %zd", friendsData.count);
        
        return friendsData.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
//        NSLog(@"Making request cell");
        UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"request"];
//        NSLog(@"request DATA for CELL: %@", [self.requestsData objectAtIndex:0]);
        cell.textLabel.text = [self.requestsData[indexPath.row][@"user_name"] description];

        
        NSDate *created = [NSDate dateWithTimeIntervalSince1970:
                           [self.requestsData[indexPath.row][@"created"] doubleValue]];
        YLMoment *moment = [YLMoment momentWithDate:created];
        NSString *timeSinceRequest = [moment fromNow];
        cell.detailTextLabel.text = timeSinceRequest;
//        NSLog(@"after setting request cell labels");
        return cell;
        
    } else {
        
//        NSLog(@"Making friend cell");
        UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"friend"];
//        NSLog(@"friend DATA for CELL: %@", [self.friendsData objectAtIndex:0]);
        
        NSString *firstName = [self.friendsData[indexPath.row][@"first_name"] description];
        NSString *lastName = [self.friendsData[indexPath.row][@"last_name"] description];
        NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        
        
        cell.textLabel.text = fullName;
        cell.detailTextLabel.text = [ self.friendsData[indexPath.row][@"user_id"] description];;
//        NSLog(@"after setting friend cell labels");
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"clicked at row %ld", (long)indexPath.row);
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *selectedCellText = selectedCell.textLabel.text;
    NSString *selectedCellId;
    NSString *alertConfirmationMessage;

    
    //  Requests section
    if (indexPath.section == 0) {
        
        selectedCellId = [self.requestsData[indexPath.row][@"user_id"] description];
        alertConfirmationMessage = [NSString stringWithFormat: @"Approve %@'s [id: %@] friend request?", selectedCellText, selectedCellId];
        
        [[SupAPIManager getSharedInstance] approveFriendRequest:selectedCellId];
    
    //  Friends section
    } else if (indexPath.section == 1) {
        
        selectedCellId = [ self.friendsData[indexPath.row][@"user_id"] description];
        alertConfirmationMessage = [NSString stringWithFormat: @"%@'s id number is %@", selectedCellText, selectedCellId];
        
    } else {
        NSLog(@"unidentified section selected");
    }
    
    
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:selectedCellText message:alertConfirmationMessage delegate:nil cancelButtonTitle:@"no" otherButtonTitles:nil];
//    [messageAlert show];
    NSLog(@"%@", alertConfirmationMessage);
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchInput = searchBar.text;
    
//    NSLog(@"--------> searchity search search: %@", searchInput);
    [[SupAPIManager getSharedInstance] searchForUser:searchInput withBlock:^(NSObject *result) {
        
        if ([result valueForKey:@"error"]) {
            NSLog(@"result with error key:\n %@", result);
            NSString *errorText = @"Invite them to join you on SUP!";
            UIAlertView *userNotFound = [[UIAlertView alloc]
                                         initWithTitle:[result valueForKey:@"error"] message:errorText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [userNotFound show];
        } else {
            NSLog(@"result has no error:\n %@", result);
        }
    }];
}



//////////////////////////////////////  boilerplate

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
