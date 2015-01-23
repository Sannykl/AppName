//
//  WishListViewController.h
//  AppName
//
//  Created by Sanny on 20.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface WishListViewController : UIViewController <SWRevealViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
