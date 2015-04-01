//
//  CreateSup.m
//  sup
//
//  Created by Sam Finegold on 3/19/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "CreateSup.h"
#import <GoogleMaps/GoogleMaps.h>
#import "SupPostManager.h"
@interface CreateSup ()

@end

@implementation CreateSup
- (void)viewDidLoad {
    [super viewDidLoad];
    [[SupPostManager getSharedInstance] addObserver:self forKeyPath:@"users" options:0 context:NULL];
    [[SupPostManager getSharedInstance] addObserver:self forKeyPath:@"postedSup" options:0 context:NULL];
}

+ (CreateSup*)getSharedInstance{
    static CreateSup *instance;
    if (instance == nil)
        instance = [[CreateSup alloc] init];
    return instance;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)postedSup:(id)sender{
    [[SupPostManager getSharedInstance] postStatus];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath boolValue] == true){
        [self performSegueWithIdentifier:@"postToMap" sender:self];
    }
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
