//
//  EditExpenseViewController.h
//  XpenseApp
//
//  Created by Iulian  Radu on 19/12/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpenseObject.h"
@interface EditExpenseViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *TypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *ValueTextField;


@property Expense *expense;

- (IBAction)BackButton:(id)sender;
@end
