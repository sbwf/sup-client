//
//  ViewController.m
//  sup
//
//  Created by Sam Finegold on 3/2/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "SupPostTableViewController.h"
#import "UsersModel.h"
#import "SupPostManager.h"
#import "CreateNewUserModel.h"
@interface SupPostTableViewController ()

@end

@implementation SupPostTableViewController
@synthesize data, table;
- (void)viewDidLoad {
    [super viewDidLoad];
    //[[UsersModel getSharedInstance] addObserver:self forKeyPath:@"users" options:0 context:NULL];
    //[[UsersModel getSharedInstance] loadData];
    
    [[SupPostManager getSharedInstance] addObserver:self forKeyPath:@"supPosts" options:0 context:NULL];
    [[SupPostManager getSharedInstance] loadStatuses];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"supPosts"]){
        NSLog(@"here");
        data = [[NSArray alloc]initWithArray:[SupPostManager getSharedInstance].supPosts];
        NSLog(@"SupPosts: %@", data);
        [table reloadData];
        NSLog(@"after reload data");
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellId = @"CustomCell";
    CustomCell *cell = (CustomCell*) [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:CellId owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.owner.text = [NSString stringWithFormat:@"Owner: %@", [[data objectAtIndex:indexPath.row] objectForKey:@"owner"]];
    cell.time.text = [NSString stringWithFormat:@"Time: %@", [[data objectAtIndex:indexPath.row] objectForKey:@"time"]];
    cell.latitude.text = [[[data objectAtIndex:indexPath.row] objectForKey:@"latitude"] stringValue];
    NSLog(@"after setting cell labels");
    return cell;
}

-(CGFloat)tableView:(UITableView*) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //if we want something to happen when we click on cells
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end