//
//  ExpensesTableViewController.m
//  XpenseApp
//
//  Created by Iulian  Radu on 31/10/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import "ExpensesTableViewController.h"
#import "Utils.h"
#import "ExpenseCell.h"
#import "EditExpenseViewController.h"
@interface ExpensesTableViewController ()

@end

@implementation ExpensesTableViewController
-(void)viewWillAppear:(BOOL)animated{
	self.view.backgroundColor = MatteWhite;
	[self getExpensesFromApi];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
	self.navigationItem.rightBarButtonItem = addButton;
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)insertNewObject:(id)sender {
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	UITabBarController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"addexpensecontroller"];
	[self presentViewController:ivc animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getExpensesFromApi{
	self.expenses = [[NSMutableArray alloc]init];

	NSString *adress = @ipadress;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	int userId = [[defaults objectForKey:@"UserId"] intValue];
	NSString* userIdString = [NSString stringWithFormat:@"%i", userId];

	adress =  [adress stringByAppendingString:@"/XpenseAPI/api/Expense/GetExpense/"];
	adress = [adress stringByAppendingString:userIdString];
	NSURL *url = [NSURL URLWithString:adress];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
	[request setURL:url];
	[request setHTTPMethod:@"GET"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	[NSURLConnection sendAsynchronousRequest:request
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response,
											   NSData *data, NSError *connectionError)
	 {
		 if (data.length > 0 && connectionError == nil)
		 {
			 NSArray *greeting = [NSJSONSerialization JSONObjectWithData:data
																	  options:0
																		error:NULL];
			 int expensesCount = [greeting count];
			 if( expensesCount){
				 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
				 NSMutableArray *expensesDefaults = [[NSMutableArray alloc]init];
				 
				 for(int i=0; i<expensesCount;i++){
					 Expense *expense = [[Expense alloc]init];
					 NSDictionary *dict = [greeting objectAtIndex:i];
					 NSMutableDictionary *dictDefaults = [[NSMutableDictionary alloc]init];
					 [dictDefaults setObject:[dict objectForKey:@"Value"] forKey:@"Value"];
					 [dictDefaults setObject:[dict objectForKey:@"Id"] forKey:@"Id"];
					 [dictDefaults setObject:[dict objectForKey:@"Type"] forKey:@"Type"];

					 expense.Value = [[dict objectForKey:@"Value"]floatValue];
					 expense.Id = [[dict objectForKey:@"Id"] intValue];
					 expense.type = [dict objectForKey:@"Type"];
					 [expensesDefaults addObject:dictDefaults];
					 [self.expenses addObject:expense];
				 }
				 [defaults setObject:expensesDefaults forKey:@"ExpensesDefaults"];
				 
				 [self.tableView reloadData];
			 }
			 else{
				 
			 }
			 
		 }
	 }];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.expenses count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 75;
}


- (ExpenseCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	Expense* expense = [self.expenses objectAtIndex:indexPath.row];
    ExpenseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"expensecell" forIndexPath:indexPath];
	NSString *value = [NSString stringWithFormat:@"%.2f",expense.Value ];
	cell.ValueLabel.text = value;
	cell.TypeLabel.text = expense.type;
	
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Expense* expense = [self.expenses objectAtIndex:indexPath.row];
	self.selectedExpense = [[Expense alloc]init];
	self.selectedExpense = expense;
	[self performSegueWithIdentifier:@"modifyExpense" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if([segue.identifier isEqualToString:@"modifyExpense"]){
		EditExpenseViewController *controller = (EditExpenseViewController *)segue.destinationViewController;
		controller.expense = [[Expense alloc]init];
		controller.expense = self.selectedExpense;
	}
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		
		NSString *adress = @ipadress;
		
		adress =  [adress stringByAppendingString:@"/XpenseAPI/api/Expense/DeleteExpense/"];
		Expense *expense = [[Expense alloc]init];
		expense = [self.expenses objectAtIndex:indexPath.row];
		int expenseId = expense.Id;
		NSString *expId = [NSString stringWithFormat:@"%d",expenseId ];
		adress = [adress stringByAppendingString:expId];
		NSURL *url = [NSURL URLWithString:adress];
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
		[request setURL:url];
		[request setHTTPMethod:@"DELETE"];
		[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
		[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		
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
				 [self.expenses removeObjectAtIndex:indexPath.row];
				 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			 }
		 }];
		
		
		
		
		
	} else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
