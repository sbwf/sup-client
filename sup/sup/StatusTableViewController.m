//
//  ViewController.m
//  sup
//
//  Created by Sam Finegold on 3/2/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "StatusTableViewController.h"
#import "UsersModel.h"
#import "SupAPIManager.h"
@interface StatusTableViewController ()

@end

@implementation StatusTableViewController
@synthesize data, table, status;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"statuses" options:0 context:NULL];
    [[SupAPIManager getSharedInstance] loadStatuses];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"statuses"]){
        NSLog(@"here");
        data = [[NSDictionary alloc]initWithDictionary:[SupAPIManager getSharedInstance].statuses];
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
    NSLog(@"In cell for row at index path");
    static NSString *CellId = @"CustomCell";
    CustomCell *cell = (CustomCell*) [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:CellId owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    status = [[NSArray alloc]initWithArray:[data objectForKey:@"statuses"]];
    NSLog(@"HERE: %@", status);
    NSLog(@"%@",[NSString stringWithFormat:@"Owner: %@", [[[status objectAtIndex:indexPath.row] objectForKey:@"owner"] stringValue]]);
    cell.owner.text = [NSString stringWithFormat:@"Owner: %@", [[[status objectAtIndex:indexPath.row] objectForKey:@"owner"] stringValue]];
    cell.time.text = [NSString stringWithFormat:@"Time: %@", [[status objectAtIndex:indexPath.row] objectForKey:@"time"]];
    cell.latitude.text = [NSString stringWithFormat:@"Latitude: %@", [[[status objectAtIndex:indexPath.row] objectForKey:@"latitude"] stringValue]];
    
    [[[status objectAtIndex:indexPath.row] objectForKey:@"latitude"] stringValue];
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