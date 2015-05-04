//
//  Map.m
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "MapViewController.h"
#import "SupAPIManager.h"
#import "NewStatusDetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()
@end

@implementation MapViewController
@synthesize statusMarkers;

+ (MapViewController*)getSharedInstance{
    static MapViewController *instance;
    if (instance == nil)
        instance = [[MapViewController alloc] init];
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.statusMarkers = [[NSMutableArray alloc] init];
    
//    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"statuses" options:NSKeyValueObservingOptionNew context:nil];
    [[SupAPIManager getSharedInstance] addObserver:self forKeyPath:@"statuses" options:NSKeyValueSetSetMutation context:nil];
    [[SupAPIManager getSharedInstance] loadStatuses];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    
    
    _mapView.myLocationEnabled = YES;
//    [self.mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    _myLocation = [[CLLocation alloc]
                   initWithLatitude: self.mapView.myLocation.coordinate.latitude
                   longitude: self.mapView.myLocation.coordinate.longitude];
    _mapView.camera = [GMSCameraPosition cameraWithLatitude:self.mapView.myLocation.coordinate.latitude
                                                  longitude:self.mapView.myLocation.coordinate.longitude
                                                       zoom:16];
    NSLog(@"View did appear, updating map");
    [self updateMap];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"In KVO: %@", keyPath);
    if ([keyPath isEqualToString:@"statuses"]){
        NSLog(@"Statuses: %@", [SupAPIManager getSharedInstance].statuses);
        for (NSDictionary *status in [SupAPIManager getSharedInstance].statuses) {
            [self.statusMarkers addObject:[[MapViewController getSharedInstance] makeMarker:[[status valueForKey:@"latitude"] doubleValue]  :[[status valueForKey:@"longitude"] doubleValue] :@"Scott": [status valueForKey:@"owner_id"]]];
//            NSLog(@"Made marker with %@", status);
        }
        NSLog(@"Status Markers %@", self.statusMarkers);
        [self updateMap];
    }
}


-(IBAction)postButtonClicked{
    //[self postStatus];
}


- (GMSMarker*)makeMarker:(double)lat :(double)lng : (NSString*)name :(NSNumber*)owner_id {
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat, lng);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.snippet = name;
    marker.userData = owner_id;
    return  marker;
}

- (void)updateMap {
    NSLog(@"Updating");
    
    for (GMSMarker *marker in self.statusMarkers) {
        NSLog(@"marker userData %@", marker.userData);
        NSLog(@"this is my id %@", [SupAPIManager getSharedInstance].myId);
        if ([marker.userData intValue] == [[SupAPIManager getSharedInstance].myId intValue] ){
            NSLog(@"In if statement, my id %@", [SupAPIManager getSharedInstance].myId);
            marker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
        }
        marker.map = _mapView;
    }
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
