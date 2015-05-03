//
//  Map.h
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
@interface MapViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (nonatomic)CLLocation *myLocation;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UIButton *postButton2;
@property (weak, nonatomic) IBOutlet UIButton *switchToListView;
@property (nonatomic) GMSMarker *myMarker;
@property (nonatomic)NSMutableArray *statusMarkers;

//@property (nonatomic, retain)NSArray *posts;
//@property (nonatomic, retain) NSString *time;
//@property (nonatomic, retain) NSString *status;

+ (MapViewController*)getSharedInstance;
-(GMSMarker*)makeMarker:(double)lat :(double)lng :(NSString*) name;
-(IBAction)postButtonClicked;

@end
