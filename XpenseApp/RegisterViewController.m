//
//  RegisterViewController.m
//  XpenseApp
//
//  Created by Iulian  Radu on 19/11/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import "RegisterViewController.h"
#import "Utils.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = MatteWhite;
	self.RegisterButton.backgroundColor = DarkGreenMatteColor;
	self.RegisterButton.layer.cornerRadius = 15;
	[self.RegisterButton setTitle:@"Register" forState:UIControlStateNormal];
	[self.RegisterButton setTitleColor:MatteWhite forState:UIControlStateNormal];
	self.UsernameTextField.placeholder = @"Username";
	self.PasswordTextField.placeholder = @"Password";
	self.NameTextField.placeholder = @"Name";
	self.UsernameTextField.backgroundColor = LightGreenMatteColor;
	self.PasswordTextField.backgroundColor = LightGreenMatteColor;
	self.NameTextField.backgroundColor = LightGreenMatteColor;
	self.EmailTextField.backgroundColor = LightGreenMatteColor;
	self.EmailTextField.placeholder = @"Email";
	self.PremiumMembershipLabel.text = @"Premium member?";
	self.PremiumMembershipLabel.textColor = LightGreenMatteColor;
	self.PremiumMembershipLabel.backgroundColor = MatteWhite;
	self.PasswordTextField.secureTextEntry = true;
    // Do any additional setup after loading the view.
	[self.NameTextField setDelegate:self];
	[self.UsernameTextField setDelegate:self];
	[self.PasswordTextField setDelegate:self];
	[self.EmailTextField setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	switch (result) {
		case MFMailComposeResultSent:
			NSLog(@"You sent the email.");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"You saved a draft of this email");
			break;
		case MFMailComposeResultCancelled:
			NSLog(@"You cancelled sending this email.");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed:  An error occurred when trying to compose this email");
			break;
		default:
			NSLog(@"An error occurred when trying to compose this email");
			break;
	}
	
	[self dismissViewControllerAnimated:YES completion:NULL];
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"tabbarcontroller"];
	[self presentViewController:ivc animated:NO completion:nil];
}


-(void)sendMail:(NSString *)email{
	if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
		mail.mailComposeDelegate = self;
		[mail setSubject:@"Welcome to Xpense!"];
		[mail setMessageBody:@"Hi! Welcome to our Xpense app." isHTML:NO];
		[mail setToRecipients:@[email]];
		
		[self presentViewController:mail animated:YES completion:NULL];
		
	}
	else
	{
		NSLog(@"This device cannot send email");
	}

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	
	[textField resignFirstResponder];
	return YES;
}
- (IBAction)RegisterButton:(id)sender {
	NSString *username = [[self.UsernameTextField text] mutableCopy];
	NSString *password = [[self.PasswordTextField text] mutableCopy];
	NSString *name = [[self.NameTextField text] mutableCopy];
	NSString *email = [[self.EmailTextField text]mutableCopy];
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
	if([name isEqualToString:@""]){
		UIAlertController * alert = [UIAlertController
									 alertControllerWithTitle:@"Error"
									 message:@"Please enter your name."
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
	if([email isEqualToString:@""]){
		UIAlertController * alert = [UIAlertController
									 alertControllerWithTitle:@"Error"
									 message:@"Please enter your name."
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
	bool premiumMember = [self.PremiumMembershipSwitch isOn] ;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	bool isOffline = [[defaults objectForKey:@"InternetConnection"]boolValue];
	if(!isOffline){

		NSString *premiumMemberString;
		if(premiumMember == true){
			 premiumMemberString = @"True";
		}
		else{
			 premiumMemberString = @"False";
		}
		NSString *adress = @ipadress;
		adress =  [adress stringByAppendingString:@"/XpenseAPI/api/Users/Register"];
		
		
		
		
		
		NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
							 username, @"Username",
							 password, @"Password",
							 name, @"Name",
							 email, @"Email",
							 premiumMemberString, @"PremiumMember",
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
					 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
					 [defaults setBool:premiumMember forKey:@"PremiumMember"];
					 [defaults setInteger:userID forKey:@"UserId"];
					 [defaults setObject:name forKey:@"Name"];
					 [defaults setObject:email forKey:@"Email"];
					 [defaults synchronize];
					 
					 [self sendMail:email];
					 
					 //HERE
					 
					 
					 
					 
				 }
				 else{
					 UIAlertController * alert = [UIAlertController
												  alertControllerWithTitle:@"Error"
												  message:message
												  preferredStyle:UIAlertControllerStyleAlert];
					 
					 UIAlertAction* okButton = [UIAlertAction
													actionWithTitle:@"Ok"
													style:UIAlertActionStyleDefault
													handler:^(UIAlertAction * action) {
														UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
														UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"loginviewcontroller"];
														[self presentViewController:ivc animated:NO completion:nil];
													}];
					 [alert addAction:okButton];
					 [self presentViewController:alert animated:YES completion:nil];
					 
					 return;
				 }
				 
			 }
		 }];
	}
	else{
		
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setBool:premiumMember forKey:@"PremiumMember"];
		//[defaults setInteger:userID forKey:@"UserId"];
		[defaults setObject:name forKey:@"Name"];
		[defaults setObject:email forKey:@"Email"];
		[defaults synchronize];
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
		UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"tabbarcontroller"];
		[self presentViewController:ivc animated:NO completion:nil];
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
@end
