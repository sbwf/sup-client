//
//  Map.m
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "MapViewController.h"
#import "SupAPIManager.h"
#import "UsersModel.h"
#import "NewStatusDetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>
@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"statuses" options:0 context:NULL];
    [[SupAPIManager getSharedInstance] loadStatuses];
    
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
    _mapView.camera = [GMSCameraPosition cameraWithLatitude:self.mapView.myLocation.coordinate.latitude
                                                  longitude:self.mapView.myLocation.coordinate.longitude
                                                       zoom:16];
    [self.mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
    
    // Do any additional setup after loading the view.
}

+ (MapViewController*)getSharedInstance{
    static MapViewController *instance;
    if (instance == nil)
        instance = [[MapViewController alloc] init];
    return instance;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"myLocation"]){
        //_mapView.myLocationEnabled = YES;
        _myLocation = [[CLLocation alloc]
            initWithLatitude: self.mapView.myLocation.coordinate.latitude
                   longitude: self.mapView.myLocation.coordinate.longitude];
        
        _mapView.camera = [GMSCameraPosition cameraWithLatitude:self.mapView.myLocation.coordinate.latitude
                                                      longitude:self.mapView.myLocation.coordinate.longitude
                                                           zoom:16];
         
        
       // NSLog(@"Latitude %f@", self.mapView.myLocation.coordinate.latitude);
        //NSLog(@"Longitude %f@", self.mapView.myLocation.coordinate.longitude);

    }
    
    if ([keyPath isEqualToString:@"statuses"]){
        NSLog(@"Observing for 'supPosts'");
        NSLog(@"SupPosts: %@", [SupAPIManager getSharedInstance].statuses);
        
        // TODO: remove existing markers
        
        for (NSDictionary *status in [[SupAPIManager getSharedInstance].statuses valueForKey:@"statuses"]){
            NSLog(@"in for loop 1");
            [self addMarker:[status valueForKey:@"latitude"] :[status valueForKey:@"longitude"] : [status valueForKey:@"owner_id"]];
        }
    }
}


-(IBAction)postButtonClicked{
    //[self postStatus];
}

-(void)addMarker:(id)lat :(id)lng :(NSNumber*)owner_Id{
    NSLog(@"In addMarker");
    NSLog(@"Latitude %f", [lat doubleValue]);
    NSLog(@"Longitude %f", [lng doubleValue]);
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = @"SUP";
    marker.map = self.mapView;
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
