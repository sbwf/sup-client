//
//  SignUp.m
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import "SignUp.h"
#import "CreateNewUserModel.h"
#include <stdlib.h>
@interface SignUp ()

@end

@implementation SignUp

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameField.tag = 1;
    _emailField.tag = 2;
    // Do any additional setup after loading the view.
}
+ (SignUp*)getSharedInstance{
    static SignUp *instance;
    if (instance == nil)
        instance = [[SignUp alloc] init];
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


-(void)addUser{
    int r = arc4random_uniform(10000000);
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/users/"];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc]initWithURL:url];
    NSDictionary *userToAdd = [NSDictionary dictionaryWithObjectsAndKeys:self.email, @"email", self.name, @"name", [NSNumber numberWithInt:r], @"id", nil];
    NSLog(@"%@", userToAdd);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userToAdd options:NSJSONWritingPrettyPrinted error:NULL];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:jsonData];
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             
             NSString *info = [NSJSONSerialization JSONObjectWithData:data
                                                              options:0
                                                                error:NULL];
             NSLog(@"Post User Message: %@", info);
         }
     }];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    //[self.view setFrame:CGRectMake(0,-110,320,460)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
   
}

-(IBAction)signedUp:(id)sender{
    [self addUser];
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
