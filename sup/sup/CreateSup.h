//
//  CreateSup.h
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
@interface CreateSup : UIViewController

@property (nonatomic, weak)IBOutlet UIButton *postButton;
-(IBAction)postedSup:(id)sender;
+ (CreateSup*)getSharedInstance;

@end
