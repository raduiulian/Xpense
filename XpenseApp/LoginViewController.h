//
//  LoginViewController.h
//  XpenseApp
//
//  Created by Iulian  Radu on 19/11/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *UsernameTextField;


@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
- (IBAction)LoginButton:(id)sender;

@end
