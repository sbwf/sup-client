//
//  FriendsPickerViewController.m
//  sup
//
//  Created by Scott Hurlow on 5/2/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "FriendsPickerViewController.h"
#import "SupAPIManager.h"

@interface FriendsPickerViewController ()

@end

@implementation FriendsPickerViewController
@synthesize table, friendsData;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Pick yo friends");
    
    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"friends" options:0 context:NULL];
//    [[SupAPIManager getSharedInstance] loadStatuses];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"statuses"]){
//        NSLog(@"here");
        friendsData = [[NSArray alloc] initWithArray:[SupAPIManager getSharedInstance].friends];
        NSLog(@"Friends Data: %@", friendsData);
        [table reloadData];
        NSLog(@"after reload data");
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
    return friendsData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Making cell");
    static NSString *CellId = @"CustomCell";
    CustomCell *cell = (CustomCell*) [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:CellId owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
//    friendsData = [[NSArray alloc]initWithArray:[data objectForKey:@"friends"]];
    NSLog(@"with friends: %@", friendsData);
//    NSLog(@"%@",[NSString stringWithFormat:@"Owner: %@", [[[status objectAtIndex:indexPath.row] objectForKey:@"owner"/] stringValue]]);
//    cell.owner.text = [NSString stringWithFormat:@"Owner: %@", [[[status objectAtIndex:indexPath.row] objectForKey:@"owner"] stringValue]];
//    cell.time.text = [NSString stringWithFormat:@"Time: %@", [[status objectAtIndex:indexPath.row] objectForKey:@"time"]];
//    cell.latitude.text = [NSString stringWithFormat:@"Latitude: %@", [[[status objectAtIndex:indexPath.row] objectForKey:@"latitude"] stringValue]];
    
//    [[[status objectAtIndex:indexPath.row] objectForKey:@"latitude"] stringValue];
    NSLog(@"after setting cell labels");
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
