//
//  RegisterViewController.h
//  XpenseApp
//
//  Created by Iulian  Radu on 19/11/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface RegisterViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *RegisterLabel;
@property (weak, nonatomic) IBOutlet UITextField *NameTextField;
@property (weak, nonatomic) IBOutlet UITextField *UsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;

@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UILabel *PremiumMembershipLabel;
@property (strong, nonatomic) IBOutlet UISwitch *PremiumMembershipSwitch;
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;

- (IBAction)RegisterButton:(id)sender;




@end
