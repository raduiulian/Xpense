//
//  LoginViewController.m
//  XpenseApp
//
//  Created by Iulian  Radu on 18/11/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import "StartUpViewController.h"
#import "Utils.h"
@interface StartUpViewController ()

@end

@implementation StartUpViewController




- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = MatteWhite;
	self.RegisterButton.backgroundColor = DarkGreenMatteColor;
	self.RegisterButton.layer.cornerRadius = 15;
	[self.RegisterButton setTitleColor:MatteWhite forState:UIControlStateNormal];
	[self.RegisterButton setTitle:@"Register" forState:UIControlStateNormal];
	self.LoginButton.backgroundColor = DarkGreenMatteColor;
	self.LoginButton.layer.cornerRadius = 15;
	[self.LoginButton setTitleColor:MatteWhite forState:UIControlStateNormal];
	[self.LoginButton setTitle:@"Login" forState:UIControlStateNormal];
	self.AppNameLabel.backgroundColor = MatteWhite;
	self.AppNameLabel.text = @"XPENSE";
	self.AppNameLabel.textColor = DarkGreenMatteColor;
	
	bool internetConnection = [self internetConnectionExist];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:internetConnection forKey:@"InternetConnection"];
    // Do any additional setup after loading the view.
}


-(bool)internetConnectionExist{
	NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.ro"];
	NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
	if (data){
		NSLog(@"Device is connected to the internet");
		return true;
	}
	else{
		NSLog(@"Device is not connected to the internet");
		return false;
	}
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

- (IBAction)RegisterButton:(id)sender {
}

- (IBAction)LoginButton:(id)sender {

}
@end
