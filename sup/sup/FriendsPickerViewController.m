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
    
    self.selectedFriends = [[NSMutableArray alloc] init];
    NSLog(@"Pick yo friends");
    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"friends" options:NSKeyValueObservingOptionInitial context:NULL];


    [[SupAPIManager getSharedInstance] loadFriends];
    
    
//    [NSThread sleepForTimeInterval:5];
    
//    NSLog(@"My Id is: %@", [SupAPIManager getSharedInstance].myId);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"friends"]){
        friendsData = [[NSArray alloc] initWithArray:[SupAPIManager getSharedInstance].friends];
        NSLog(@"KVO reload friends");
        [self.tableView reloadData];
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
//    NSLog(@"Num Friends: %zd", friendsData.count);
    return friendsData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"friend"];
    NSLog(@"friend DATA for CELL: %@", [self.friendsData objectAtIndex:indexPath.row]);
    
    NSString *firstName = [self.friendsData[indexPath.row][@"first_name"] description];
    NSString *lastName = [self.friendsData[indexPath.row][@"last_name"] description];
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    cell.textLabel.text = fullName;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSNumber *selectedID = [[self.friendsData objectAtIndex:indexPath.row] valueForKey:@"user_id"];
    UIColor *blue = [[UIColor alloc] initWithRed:255 green:127 blue:0 alpha:1];
    if ([self.selectedFriends containsObject:selectedID]) {
        [self.selectedFriends removeObject:selectedID];
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        [self.selectedFriends addObject:selectedID];
        cell.backgroundColor = [UIColor blueColor];
    }
    NSLog(@"Selected Users: %@", self.selectedFriends);
}


//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSNumber *selectedID = [[self.friendsData objectAtIndex:indexPath.row] valueForKey:@"user_id"];
//    if (self.selectedFriends containsObject:selectedID) {
//        
//    }
//    [self.selectedFriends removeObject:selectedFriends];
//    NSLog(@"Selected Users: %@", self.selectedFriends);
//}

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
        statusDetailCtrl.friends = [[NSMutableArray alloc]init];
        statusDetailCtrl.friends = self.selectedFriends;
        NSLog(@"Picked Friends: %@", self.selectedFriends);
    }
    
    
}

@end
