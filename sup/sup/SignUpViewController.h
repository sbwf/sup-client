//
//  SignUp.h
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UITextFieldDelegate>{
    UIAlertView *confirmSignUp;
}

@property (nonatomic, strong)NSString *firstName;
@property (nonatomic, strong)NSString *lastName;
@property (nonatomic, strong)NSString *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *table;
@property (weak, nonatomic) IBOutlet UIButton *signUp;

//+(SignUpViewController*)getSharedInstance;
-(IBAction)signedUp:(id)sender;

@end
