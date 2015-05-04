//
//  RequestCell.h
//  sup
//
//  Created by Will Kent-Daggett on 5/3/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UILabel *userId;
@property (nonatomic, weak)IBOutlet UILabel *requestedId;
@property (nonatomic, strong)IBOutlet UILabel *created;

@end
