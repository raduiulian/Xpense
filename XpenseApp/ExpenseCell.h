//
//  ExpenseCell.h
//  XpenseApp
//
//  Created by Iulian  Radu on 10/12/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *TypeLabel;
@end
