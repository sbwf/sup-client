//
//  FriendsHubViewController.h
//  sup
//
//  Created by Sam Finegold on 4/15/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FriendsHubViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, retain)NSArray *friendsData;
@property (nonatomic, retain)NSArray *requestsData;


@end
