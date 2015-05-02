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
@synthesize table1, table2, data, friends;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [[FriendManager getSharedInstance] addObserver:self forKeyPath:@"friends" options:0 context:NULL];
    [[FriendManager getSharedInstance] getFriendsOfUser:(NSInteger *) 1];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"friends"]){
        NSLog(@"here");
        data = [[NSDictionary alloc]initWithDictionary:[FriendManager getSharedInstance].friends];
        NSLog(@"Friends: %@", data);
        [table2 reloadData];
        NSLog(@"after reload data");
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"In cell for row at index path");
    static NSString *CellId = @"FriendCell";
    FriendCell *cell = (FriendCell*) [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:CellId owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    friends = [[NSArray alloc]initWithArray:[data objectForKey:@"friends"]];
    NSLog(@"HERE: %@", friends);
    NSLog(@"%@",[NSString stringWithFormat:@"Owner: %@", [[[friends objectAtIndex:indexPath.row] objectForKey:@"user_id"] stringValue]]);
    cell.firstName.text = [NSString stringWithFormat:@"First name: %@", [[[friends objectAtIndex:indexPath.row] objectForKey:@"first_name"] stringValue]];
    cell.lastName.text = [NSString stringWithFormat:@"Last name: %@", [[friends objectAtIndex:indexPath.row] objectForKey:@"last_name"]];
//    cell.lastActive.text = [NSString stringWithFormat:@"Latitude: %@", [[[friends objectAtIndex:indexPath.row] objectForKey:@"xxx"] stringValue]];
    
    [[[friends objectAtIndex:indexPath.row] objectForKey:@"latitude"] stringValue];
    NSLog(@"after setting cell labels");
    return cell;
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
