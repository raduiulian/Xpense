//
//  LoginViewController.m
//  XpenseApp
//
//  Created by Iulian  Radu on 19/11/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import "LoginViewController.h"
#import "Utils.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = MatteWhite;
	self.LoginButton.backgroundColor = DarkGreenMatteColor;
	self.LoginButton.layer.cornerRadius = 15;
	[self.LoginButton setTitle:@"Login" forState:UIControlStateNormal];
	[self.LoginButton setTitleColor:MatteWhite forState:UIControlStateNormal];
	self.UsernameTextField.placeholder = @"Username";
	self.PasswordTextField.placeholder = @"Password";
	self.PasswordTextField.secureTextEntry = true;
	self.UsernameTextField.backgroundColor = LightGreenMatteColor;
	self.PasswordTextField.backgroundColor = LightGreenMatteColor;
    // Do any additional setup after loading the view.
	[self.UsernameTextField setDelegate:self];
	[self.PasswordTextField setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	
	return YES;
}


- (IBAction)LoginButton:(id)sender {
	
	NSString *username = [[self.UsernameTextField text] mutableCopy];
	NSString *password = [[self.PasswordTextField text] mutableCopy];
	bool errors = false;
	if([username isEqualToString:@""]){
		UIAlertController * alert = [UIAlertController
									 alertControllerWithTitle:@"Error"
									 message:@"Please enter your username."
									 preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* okButton = [UIAlertAction
								   actionWithTitle:@"Ok"
								   style:UIAlertActionStyleDefault
								   handler:^(UIAlertAction * action) {
									   //Handle no, thanks button
								   }];
		[alert addAction:okButton];
		[self presentViewController:alert animated:YES completion:nil];
		errors = true;
	}
	if([password isEqualToString:@""]){
		UIAlertController * alert = [UIAlertController
									 alertControllerWithTitle:@"Error"
									 message:@"Please enter your password."
									 preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* okButton = [UIAlertAction
								   actionWithTitle:@"Ok"
								   style:UIAlertActionStyleDefault
								   handler:^(UIAlertAction * action) {
									   //Handle no, thanks button
								   }];
		[alert addAction:okButton];
		[self presentViewController:alert animated:YES completion:nil];
		errors = false;
	}
	if(errors == true){
		return;
	}
	
	
	NSString *adress = @ipadress;
	adress =  [adress stringByAppendingString:@"/XpenseAPI/api/Users/Login"];
	NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
						 username, @"Username",
						 password, @"Password",
						 nil];
	NSURL *url = [NSURL URLWithString:adress];
	
	NSError *error;
	NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
	[request setURL:url];
	[request setHTTPBody:postdata];
	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postdata length]] forHTTPHeaderField:@"Content-Length"];

	[NSURLConnection sendAsynchronousRequest:request
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response,
											   NSData *data, NSError *connectionError)
	 {
		 if (data.length > 0 && connectionError == nil)
		 {
			 NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
																	  options:0
																		error:NULL];
			 NSString *success = [greeting objectForKey:@"Success"];
			 NSString *message = [greeting objectForKey:@"Message"];
			 if([success isEqualToString:@"true"]){
				 int userID = [[greeting objectForKey:@"Id"] intValue];
				 bool premiumMember = [[greeting objectForKey:@"PremiumMember"] boolValue];
				 NSString *name = [greeting objectForKey:@"Name"];
				 NSString *email = [greeting objectForKey:@"Email"];
				 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
				 [defaults setBool:premiumMember forKey:@"PremiumMember"];
				 [defaults setInteger:userID forKey:@"UserId"];
				 [defaults setObject:name forKey:@"Name"];
				 [defaults setObject:email forKey:@"Email"];
				 [defaults synchronize];
				 
				 
				 //HERE 
				 
				 
				 
				 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
				 UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"tabbarcontroller"];
				 [self presentViewController:ivc animated:NO completion:nil];

			 }
			 else{
				 UIAlertController * alert = [UIAlertController
											  alertControllerWithTitle:@"Error"
											  message:message
											  preferredStyle:UIAlertControllerStyleAlert];
				 UIAlertAction* createAccountButton = [UIAlertAction
								   actionWithTitle:@"Create account?"
								   style:UIAlertActionStyleDefault
								   handler:^(UIAlertAction * action) {
									   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
									   UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"registerviewcontroller"];
									   [self presentViewController:ivc animated:NO completion:nil];
								   }];
				 UIAlertAction* cancelButton = [UIAlertAction
								   actionWithTitle:@"Cancel"
								   style:UIAlertActionStyleDefault
								   handler:^(UIAlertAction * action) {
									   
								   }];
				 [alert addAction:createAccountButton];
				 [alert addAction:cancelButton];
				 [self presentViewController:alert animated:YES completion:nil];

				 return;
			 }
			 
		 }
	 }];
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
@end
