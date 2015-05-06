//
//  ViewController.h
//  sup
//
//  Created by Sam Finegold on 3/11/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CustomCell.h"

@interface StatusTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property IBOutlet UITableView *table;
//@property (nonatomic, retain)NSDictionary *data;
@property (nonatomic, retain)NSMutableArray *statusData;
@property IBOutlet UIButton *map;
@end

