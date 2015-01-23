//
//  GrowTipsViewController.m
//  AppName
//
//  Created by Sanny on 20.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import "GrowTipsViewController.h"

@interface GrowTipsViewController ()

@property (nonatomic, strong) UIButton *revealButton;

@end

@implementation GrowTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GROW TIPS";

    SWRevealViewController *revealController = [self revealViewController];
    revealController.delegate = self;
    
    [revealController tapGestureRecognizer];
    
    self.revealButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 43, 35)];
    [self.revealButton setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateNormal];
    [self.revealButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.revealButton];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
