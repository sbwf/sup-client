//
//  FriendCell.h
//  sup
//
//  Created by Scott Hurlow on 5/2/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UILabel *firstname;
@property (nonatomic, weak)IBOutlet UILabel *lastname;
@property (nonatomic, weak)IBOutlet UILabel *phone;

@end
