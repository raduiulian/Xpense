//
//  EditExpenseViewController.m
//  XpenseApp
//
//  Created by Iulian  Radu on 19/12/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import "EditExpenseViewController.h"
#import "Utils.h"
@interface EditExpenseViewController ()

@end

@implementation EditExpenseViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.TypeTextField.delegate = self;
	self.ValueTextField.delegate = self;
	// Do any additional setup after loading the view.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	
	[textField resignFirstResponder];
	return YES;
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

- (IBAction)BackButton:(id)sender {
	
	
	if(![self.TypeTextField.text isEqualToString:@""] && ![self.ValueTextField.text isEqualToString:@""]){
		
		float value = [self.ValueTextField.text floatValue];
		if(value != 0){
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			NSString *adress = @ipadress;
			NSNumber * valueNumber = [[NSNumber alloc]init];
			NSNumber *expenseId = [[NSNumber alloc]init];
			expenseId = [NSNumber numberWithInt:self.expense.Id];
			valueNumber = [NSNumber numberWithFloat:value];
			adress =  [adress stringByAppendingString:@"/XpenseAPI/api/Expense/UpdateExpense"];
			NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
								 valueNumber, @"Value",
								 self.TypeTextField.text, @"Type",
								 expenseId,@"Id",
								 nil];
			NSURL *url = [NSURL URLWithString:adress];
			
			NSError *error;
			NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
			NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
			[request setURL:url];
			[request setHTTPBody:postdata];
			[request setHTTPMethod:@"PUT"];
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
					 
					 
					 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
					 UITabBarController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"tabbarcontroller"];
					 [self presentViewController:ivc animated:YES completion:nil];
				 }
			 }];
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}
@end
