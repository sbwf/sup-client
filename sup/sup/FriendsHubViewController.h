//
//  FriendsHubViewController.h
//  sup
//
//  Created by Sam Finegold on 4/15/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsHubViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property IBOutlet UITableView *table1;
@property IBOutlet UITableView *table2;

@end
