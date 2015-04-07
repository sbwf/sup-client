//
//  SignUp.m
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "SignUpViewController.h"
#import "CreateNewUserModel.h"
#include <stdlib.h>
@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nameField.tag = 1;
    _emailField.tag = 2;
}
+ (SignUpViewController*)getSharedInstance{
    static SignUpViewController *instance;
    if (instance == nil)
        instance = [[SignUpViewController alloc] init];
    return instance;
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
        self.name = textField.text;
        UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:2];
        [passwordTextField becomeFirstResponder];
    }
    else {
        self.email = [[NSString alloc]initWithString:textField.text];
        [textField resignFirstResponder];
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

-(IBAction)signedUp:(id)sender{
    int r = arc4random_uniform(10000000);
    [[CreateNewUserModel getSharedInstance] addUser:self.name :self.email : [NSNumber numberWithInt:r]];
    confirmSignUp =[[UIAlertView alloc]initWithTitle:@"Congratulations" message:@"You are now signed up!" delegate:self cancelButtonTitle:@"Ok"otherButtonTitles:nil];
    [confirmSignUp show];
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
