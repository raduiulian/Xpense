//
//  ExpensesTableViewController.h
//  XpenseApp
//
//  Created by Iulian  Radu on 31/10/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpenseObject.h"


@interface ExpensesTableViewController : UITableViewController
@property NSMutableArray *expenses;
@property Expense *selectedExpense;

@end
