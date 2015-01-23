//
//  ProfileViewController.h
//  AppName
//
//  Created by Sanny on 20.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface ProfileViewController : UIViewController <SWRevealViewControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIView *userNameEditView;
@property (weak, nonatomic) IBOutlet UIView *passwordEditView;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *choiceButton;
@property (weak, nonatomic) IBOutlet UIButton *kilometersButton;
@property (weak, nonatomic) IBOutlet UIButton *milesButton;

- (IBAction)saveButtonClick:(id)sender;
- (IBAction)choiceButtonClick:(id)sender;
- (IBAction)kilometersButtonClick:(id)sender;
- (IBAction)milesButtonClick:(id)sender;

@end
