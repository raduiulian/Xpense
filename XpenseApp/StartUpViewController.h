//
//  StartUpViewController.h
//  XpenseApp
//
//  Created by Iulian  Radu on 18/11/2017.
//  Copyright © 2017 Iulian  Radu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;
- (IBAction)RegisterButton:(id)sender;
- (IBAction)LoginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *AppNameLabel;

@end
