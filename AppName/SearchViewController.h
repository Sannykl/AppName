//
//  SearchViewController.h
//  AppName
//
//  Created by Sanny on 19.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "GlobalSettings.h"

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *leftSearchButton;
@property (weak, nonatomic) IBOutlet UIButton *rightSearchButton;
@property (weak, nonatomic) IBOutlet UIButton *sortButton;
@property (weak, nonatomic) IBOutlet UITableView *popupTableView;

- (IBAction)leftSearchButtonClick:(id)sender;
- (IBAction)rightSearchButtonClick:(id)sender;
- (IBAction)sortButtonClick:(id)sender;

@end
