//
//  RequestCell.h
//  sup
//
//  Created by Will Kent-Daggett on 5/2/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UILabel *requester_id;
@property (nonatomic, weak)IBOutlet UILabel *requested_id;
@property (nonatomic, weak)IBOutlet UILabel *requestedAt;

@end
