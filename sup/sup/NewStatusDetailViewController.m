//
//  SupPostDetailsViewController.m
//  sup
//
//  Created by Sam Finegold on 4/15/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "NewStatusDetailViewController.h"
#import "MapViewController.h"
#import "SupAPIManager.h"
@interface NewStatusDetailViewController ()

@end

@implementation NewStatusDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _timeField.tag = 1;
    _statusField.tag = 2;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    
    _userLocation = [[CLLocation alloc]
                   initWithLatitude: locationManager.location.coordinate.latitude
                   longitude: locationManager.location.coordinate.longitude];
    NSLog(@"User location latitude, %f", _userLocation.coordinate.latitude);
    NSLog(@"User location latitude, %f", _userLocation.coordinate.longitude);

    // Do any additional setup after loading the view.
    //[SupAPIManager getSharedInstance].myId = @(2);
    NSLog(@"Selected Friends: %@", self.friends);
}

+ (NewStatusDetailViewController*)getSharedInstance{
    static NewStatusDetailViewController *instance;
    if (instance == nil)
        instance = [[NewStatusDetailViewController alloc] init];
    return instance;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"textFieldShouldClear:");
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        self.time = (NSNumber*) textField.text;
    }
    else if (textField.tag == 2){
        self.status = [[NSString alloc]initWithString:textField.text];
    }
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    
}

-(IBAction)postButtonClicked{
    NSLog(@"LATITUDE ...%f@", _userLocation.coordinate.latitude);
    NSLog(@"LONGITUDE... %f@", _userLocation.coordinate.longitude);
    NSLog(@"DURATION... %@", self.time);
    [[SupAPIManager getSharedInstance] postStatus:_userLocation :self.friends: self.time];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
