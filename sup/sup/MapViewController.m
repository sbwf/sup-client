//
//  Map.m
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "MapViewController.h"
#import "SupPostManager.h"
#import "UsersModel.h"
#import <GoogleMaps/GoogleMaps.h>
@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SupPostManager getSharedInstance] addObserver:self forKeyPath:@"supPosts" options:0 context:NULL];
    [[SupPostManager getSharedInstance] loadStatuses];
    
    _mapView.myLocationEnabled = YES;
    _mapView.camera = [GMSCameraPosition cameraWithLatitude:44.934207
                                                  longitude:-93.167494
                                                       zoom:16];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"supPosts"]){
        NSLog(@"Observing for 'supPosts'");
        NSLog(@"SupPosts: %@", [SupPostManager getSharedInstance].supPosts);
            
        // TODO: remove existing markers
            
            
        for (NSDictionary* status in [SupPostManager getSharedInstance].supPosts){
            [self addMarker:[status valueForKey:@"latitude"] :[status valueForKey:@"longitude"] : [status valueForKey:@"owner_id"]];
        }
    }
}
-(void)addMarker:(id)lat :(id)lng :(NSNumber*)owner_Id{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([lat floatValue], [lng floatValue]);
    marker.title = @"SUP";
    marker.map = _mapView;
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
