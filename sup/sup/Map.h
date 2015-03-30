//
//  Map.h
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
@interface Map : UIViewController
{
    GMSMapView *mapView_;
}
@property (nonatomic, retain)NSArray *posts;
@end
