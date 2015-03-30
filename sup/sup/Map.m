//
//  Map.m
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "Map.h"
#import "SupPost.h"
#import <GoogleMaps/GoogleMaps.h>
@interface Map ()

@end

@implementation Map
@synthesize posts;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    [[SupPost getSharedInstance] addObserver:self forKeyPath:@"supPosts" options:0 context:NULL];
    [[SupPost getSharedInstance] post];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"supPosts"]){
        NSLog(@"Observing for 'supPosts'");
        NSLog(@"SupPosts: %@", [SupPost getSharedInstance].supPosts);
        posts = [[NSArray alloc]initWithArray:[SupPost getSharedInstance].supPosts];
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:44.934310
                                                                longitude:-93.167929
                                                                     zoom:16];
        mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        mapView_.myLocationEnabled = YES;
        self.view = mapView_;

        for (NSDictionary* status in posts){
            //NSLog(@"Location: %@", [status objectForKey:@"latitude"]);
            [self addMarker:[status valueForKey:@"latitude"] :[status valueForKey:@"longitude"]];
        }
    
    }
}
-(void)addMarker:(id)lat :(id)lng{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([lat floatValue], [lng floatValue]);
    marker.title = @"Sup";
    marker.map = mapView_;
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
