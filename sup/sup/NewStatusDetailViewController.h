//
//  SupPostDetailsViewController.h
//  sup
//
//  Created by Sam Finegold on 4/15/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface NewStatusDetailViewController : UIViewController<UITextFieldDelegate, CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet UITextField *statusField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UIButton *postButton;


@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSNumber *time;
@property (nonatomic, strong)NSMutableSet *friends;
@property (nonatomic)CLLocation *userLocation;



+(NewStatusDetailViewController*)getSharedInstance;
-(IBAction)postButtonClicked;

@end
