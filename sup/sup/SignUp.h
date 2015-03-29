//
//  SignUp.h
//  sup
//
//  Created by Sam Finegold on 3/29/15.
//  Copyright (c) 2015 Sam Finegold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUp : UIViewController<UITextFieldDelegate>
{
    NSString *name2;
}
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *email;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *table;
@property (weak, nonatomic) IBOutlet UIButton *signUp;

+(SignUp*)getSharedInstance;
-(NSString *) getName;
-(NSString *) getEmail;
-
(void)addUser;
-(IBAction)signedUp:(id)sender;

@end
