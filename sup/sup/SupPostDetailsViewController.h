//
//  SupPostDetailsViewController.h
//  sup
//
//  Created by Sam Finegold on 4/15/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupPostDetailsViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *status;
@property (weak, nonatomic) IBOutlet UITextField *time;

+(SupPostDetailsViewController*)getSharedInstance;

@end
