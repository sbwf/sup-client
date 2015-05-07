//
//  FriendsPickerViewController.h
//  sup
//
//  Created by Scott Hurlow on 5/2/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FriendCell.h"

@interface FriendsPickerViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property IBOutlet UITableView *table;
@property (nonatomic, retain)NSArray *friendsData;
@property (nonatomic, retain)NSMutableArray *selectedFriends;


@end
