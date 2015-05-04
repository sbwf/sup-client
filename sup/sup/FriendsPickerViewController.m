//
//  FriendsPickerViewController.m
//  sup
//
//  Created by Scott Hurlow on 5/2/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "FriendsPickerViewController.h"
#import "NewStatusDetailViewController.h"
#import "SupAPIManager.h"

@interface FriendsPickerViewController ()

@end

@implementation FriendsPickerViewController
@synthesize table, friendsData, selectedFriends;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Pick yo friends");
    [SupAPIManager getSharedInstance].myId = @(2);
    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"friends" options:0 context:NULL];

    self.selectedFriends = [[NSMutableArray alloc] init];
    [[SupAPIManager getSharedInstance] loadFriends];
    
    
//    [NSThread sleepForTimeInterval:5];
    
    NSLog(@"My Id is: %@", [SupAPIManager getSharedInstance].myId);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"friends"]){
        friendsData = [[NSArray alloc] initWithArray:[SupAPIManager getSharedInstance].friends];
//        NSLog(@"Friends Data: %@", friendsData);
        [table reloadData];
        NSLog(@"KVO reload friends");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"Num Friends: %zd", friendsData.count);
    return friendsData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Making cell");
    static NSString *CellId = @"FriendCell";
    FriendCell *cell = (FriendCell*) [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:CellId owner:self options:nil];
        cell = [nib objectAtIndex:0];
        NSLog(@"Null cell");
    }
    
//    friendsData = [[NSArray alloc]initWithArray:[data objectForKey:@"friends"]];
    NSLog(@"Friends DATA for CELL: %@", friendsData);
    cell.firstname.text = [NSString stringWithString:[[friendsData objectAtIndex:indexPath.row] objectForKey:@"first_name"]];
    cell.lastname.text = [NSString stringWithString:[[friendsData objectAtIndex:indexPath.row] objectForKey:@"last_name"]];
    cell.friend_Id = [[friendsData objectAtIndex:indexPath.row] objectForKey:@"user_id"];
    NSLog(@"after setting cell labels");
    return cell;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = (FriendCell*)[tableView cellForRowAtIndexPath:indexPath];
    if ([self.selectedFriends containsObject:cell.friend_Id]) {
        [self.selectedFriends removeObject:cell.friend_Id];
        [cell setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    } else {
        [self.selectedFriends addObject:cell.friend_Id];
        [cell setBackgroundColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:0.6]];
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"In Segue");
    
    if ([[segue identifier] isEqualToString:@"PickedFriends"]) {
        NewStatusDetailViewController *statusDetailCtrl = segue.destinationViewController;
        statusDetailCtrl.friends = self.selectedFriends;
    }
    
    
}

@end
