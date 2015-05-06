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

//@property (nonatomic)UIStoryboard *storyboard;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (nonatomic) GMSMarker *myMarker;
@property (nonatomic)CLLocation *myLocation;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UIButton *postButton2;
@property (weak, nonatomic) IBOutlet UIButton *switchToListView;
@property (nonatomic)NSMutableArray *statusMarkers;

- (void)updateMap;
-(GMSMarker*)makeMarker:(double)lat :(double)lng :(NSString*) name:(NSString*)duration :(NSNumber*) owner_id;
-(IBAction)postButtonClicked;

@end
