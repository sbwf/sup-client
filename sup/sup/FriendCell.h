//
//  FriendCell.h
//  sup
//
//  Created by Will Kent-Daggett on 5/1/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UILabel *firstName;
@property (nonatomic, weak)IBOutlet UILabel *lastName;
//@property (nonatomic, weak)IBOutlet UILabel *lastActive;

@end
