//
//  AddExpenseViewController.h
//  XpenseApp
//
//  Created by Iulian  Radu on 12/12/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddExpenseViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *TypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *ValueTextField;
- (IBAction)AddExpense:(id)sender;

@end
