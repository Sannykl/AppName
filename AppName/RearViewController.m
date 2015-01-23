//
//  RearViewController.m
//  AppName
//
//  Created by Sanny on 19.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import "RearViewController.h"
#import "SearchViewController.h"
#import "WishListViewController.h"
#import "GrowTipsViewController.h"
#import "ProfileViewController.h"

@interface RearViewController ()
{
    CGFloat screenWidth;
    CGFloat screenHeight;
    NSInteger presentedRow;
}
@end

@implementation RearViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    [self.navigationController.navigationBar setHidden:YES];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self customizeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeView {
    
    self.tableView.frame = CGRectMake(0, 0, screenWidth/2, screenHeight);
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table View Controller Delegate & DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0, cell.frame.size.height-1.0, cell.frame.size.width, 1.0);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [cell.layer addSublayer:bottomBorder];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor grayColor];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"SEARCH";
            break;
            
        case 1:
            cell.textLabel.text = @"WISHLIST";
            break;
            
        case 2:
            cell.textLabel.text = @"GROW TIPS";
            break;
            
        case 3:
            cell.textLabel.text = @"PROFILE";
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    NSInteger row = indexPath.row;
    
    UIViewController *newFrontController = nil;
    
    if (row == 0) {
        
        newFrontController = [[SearchViewController alloc] init];
    } else if (row == 1) {
        
        newFrontController = [[WishListViewController alloc] init];
    } else if (row == 2) {
        
        newFrontController = [[GrowTipsViewController alloc] init];
    } else if (row == 3) {
        
        newFrontController = [[ProfileViewController alloc] init];
    }
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
    [revealController pushFrontViewController:navigationController animated:YES];
    
    presentedRow = row;  // <- store the presented row
}


@end
