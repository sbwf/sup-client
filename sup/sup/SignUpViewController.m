//
//  SignUp.m
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "SignUpViewController.h"
#import "SupAPIManager.h"
#include <stdlib.h>
@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstNameField.tag = 1;
    _lastNameField.tag = 2;
    _phoneNumberField.tag = 3;
}

//+ (SignUpViewController*)getSharedInstance{
//    static SignUpViewController *instance;
//    if (instance == nil)
//        instance = [[SignUpViewController alloc] init];
//    return instance;
//}

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
        self.firstName = textField.text;
        UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:2];
        [passwordTextField becomeFirstResponder];
    }
    if (textField.tag == 2){
        self.lastName = [[NSString alloc]initWithString:textField.text];
        [textField resignFirstResponder];
    }
    if (textField.tag == 3){
        self.phoneNumber = [[NSString alloc]initWithString:textField.text];
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
    if (self.firstName && self.lastName && self.phoneNumber) {
        [[SupAPIManager getSharedInstance] addUser:self.firstName :self.lastName :self.phoneNumber withBlock:^(NSNumber *newId) {
            NSUserDefaults *savedUser = [NSUserDefaults standardUserDefaults];
            [savedUser setObject:newId forKey:@"savedUser"];
            [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    } else {
        NSLog(@"Found nil in input");
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Uh oh!"
                              message:@"Your Info wasn't entered correctly!"
                              delegate:self
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        [alert show];
    }

    //TODO: confirmation that user signed up successfully
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
