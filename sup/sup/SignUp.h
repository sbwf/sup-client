//
//  SignUp.h
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUp : UIViewController<UITextFieldDelegate>{
    UIAlertView *confirmSignUp;
}

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *email;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *table;
@property (weak, nonatomic) IBOutlet UIButton *signUp;

+(SignUp*)getSharedInstance;
-(IBAction)signedUp:(id)sender;

@end
