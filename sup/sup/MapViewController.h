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
@interface MapViewController : UIViewController
{
}
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (nonatomic)CLLocation *myLocation;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UIButton *postButton2;
@property (weak, nonatomic) IBOutlet UIButton *switchToListView;

@property (nonatomic, retain)NSArray *posts;

-(void)postStatus;
-(void)addMarker:(id)lat :(id)lng :(NSNumber*)owner_Id;
-(IBAction)postButtonClicked;

@end
