//
//  CustomCell.h
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UILabel *owner;
@property (nonatomic, weak)IBOutlet UILabel *time;
@property (nonatomic, weak)IBOutlet UILabel *latitude;

@end
