//
//  SupPostDetailsViewController.m
//  sup
//
//  Created by Sam Finegold on 4/15/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "NewStatusDetailViewController.h"
#import "MapViewController.h"
#import "SupAPIManager.h"
@interface NewStatusDetailViewController ()

@end

@implementation NewStatusDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _timeField.tag = 1;
    _statusField.tag = 2;
    
    
    [[MapViewController getSharedInstance] addObserver:self forKeyPath:@"myLocation" options:0 context:NULL];

    // Do any additional setup after loading the view.
}

+ (NewStatusDetailViewController*)getSharedInstance{
    static NewStatusDetailViewController *instance;
    if (instance == nil)
        instance = [[NewStatusDetailViewController alloc] init];
    return instance;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"myLocation"]){
        NSLog(@"User location: %@", [MapViewController getSharedInstance].myLocation);
        _userLocation = [MapViewController getSharedInstance].myLocation;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"textFieldShouldClear:");
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        self.time = textField.text;
    }
    else if (textField.tag == 2){
        self.status = [[NSString alloc]initWithString:textField.text];
    }
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    
}

-(IBAction)postButtonClicked{
    [[SupAPIManager getSharedInstance] postStatus:_userLocation];
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
