//
//  Map.m
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "MapViewController.h"
#import "SupAPIManager.h"
#import "SignUpViewController.h"
#import "NewStatusDetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "YLMoment.h"

@interface MapViewController ()
@end

@implementation MapViewController
@synthesize statusMarkers;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.statusMarkers = [[NSMutableArray alloc] init];
    
    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"statuses" options:NSKeyValueSetSetMutation context:nil];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    _mapView.myLocationEnabled = YES;
    _myLocation = [[CLLocation alloc]
                   initWithLatitude: self.mapView.myLocation.coordinate.latitude
                   longitude: self.mapView.myLocation.coordinate.longitude];
//    [self.mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *savedUser = [NSUserDefaults standardUserDefaults];
    
    // JUST FOR TESTING
//    [savedUser removeObjectForKey:@"savedUser"];
    //
    
    
    // If NO saved user is found, promt user to sign up
    if (![savedUser objectForKey:@"savedUser"]) {
        NSLog(@"No User :(");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SignUpViewController *signUp = [storyboard instantiateViewControllerWithIdentifier:@"SignUpView"];
        [self presentViewController:signUp animated:YES completion:^{
            NSLog(@"Did transition");
        }];
        
    // If a saved user exists:
    } else {
        [SupAPIManager getSharedInstance].myId = [savedUser objectForKey:@"savedUser"];
        NSLog(@"Saved User: %@", [savedUser objectForKey:@"savedUser"]);
    }
    /*
    _myLocation = [[CLLocation alloc]
                   initWithLatitude: self.mapView.myLocation.coordinate.latitude
                   longitude: self.mapView.myLocation.coordinate.longitude];
     */
    NSLog(@"Latitude %f", self.mapView.myLocation.coordinate.latitude);
    NSLog(@"Longitude %f", self.mapView.myLocation.coordinate.longitude);
    
    _mapView.camera = [GMSCameraPosition cameraWithLatitude:self.mapView.myLocation.coordinate.latitude
                                                  longitude:self.mapView.myLocation.coordinate.longitude
                                                       zoom:16];
    NSLog(@"View did appear, updating map");
    [[SupAPIManager getSharedInstance] loadStatuses];
    [self updateMap];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"In KVO: %@", keyPath);
    if ([keyPath isEqualToString:@"statuses"]){
        NSLog(@"Statuses: %@", [SupAPIManager getSharedInstance].statuses);
        for (NSDictionary *status in [SupAPIManager getSharedInstance].statuses) {
            [self.statusMarkers addObject:[self makeMarker:[[status valueForKey:@"latitude"] doubleValue]  :[[status valueForKey:@"longitude"] doubleValue] :[status valueForKey:@"owner_name"]: [status valueForKey:@"expires"]:[status valueForKey:@"message"]: [status valueForKey:@"owner_id"]]];
        }
        [self updateMap];
    }
}

-(IBAction)statusTableButtonClicked{
    NSLog(@"Status Table Button");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewStatusDetailViewController *statusTable = [storyboard instantiateViewControllerWithIdentifier:@"StatusTableView"];
    [statusTable setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:statusTable animated:YES completion:^{
        //        NSLog(@"Did transition to status table view");
    }];
}

-(IBAction)postButtonClicked{
    NSLog(@"Post Button");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewStatusDetailViewController *newStatusView = [storyboard instantiateViewControllerWithIdentifier:@"NewStatusView"];
    [newStatusView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:newStatusView animated:YES completion:^{
        NSLog(@"Did transition to new status");
    }];
}

- (IBAction)refreshButton{
    [[SupAPIManager getSharedInstance] loadStatuses];
    NSLog(@"button pressed");
}


- (GMSMarker*)makeMarker:(double)lat :(double)lng : (NSString*)name :(NSNumber*) expirationDate :(NSString*)message: (NSNumber*)owner_id {
    NSDate *expDate = [NSDate dateWithTimeIntervalSince1970: [expirationDate doubleValue] ];
    YLMoment *moment = [YLMoment momentWithDate:expDate];
    NSString *expiresIn = [moment fromNow];
    NSLog(@"expires: %@", expiresIn);
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat, lng);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = name;
    marker.icon = [UIImage imageNamed:@"theirPin"];
    marker.snippet = [NSString stringWithFormat:@"Ends %@ \n\nStatus: %@", expiresIn, message];
    marker.userData = owner_id;
    return  marker;
}

- (void)updateMap {
    NSLog(@"Updating");
    for (GMSMarker *marker in self.statusMarkers) {
        if ([marker.userData intValue] == [[SupAPIManager getSharedInstance].myId intValue] ){
            marker.icon = [UIImage imageNamed:@"yourPin"];
        }
        marker.map = _mapView;
    }
}

-(void)dealloc{
        [[SupAPIManager getSharedInstance] removeObserver:self forKeyPath:@"statuses"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
