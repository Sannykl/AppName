//
//  ProfileViewController.m
//  AppName
//
//  Created by Sanny on 20.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import "ProfileViewController.h"
#import "SettingsController.h"
#import "Settings.h"
#import "GlobalSettings.h"

@interface ProfileViewController ()

@property (nonatomic, strong) UIButton *revealButton;
@property (nonatomic, strong) Settings *settings;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"PROFILE";
    
    SWRevealViewController *revealController = [self revealViewController];
    revealController.delegate = self;
    
    [revealController tapGestureRecognizer];
    
    self.revealButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 43, 35)];
    [self.revealButton setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateNormal];
    [self.revealButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.revealButton];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.userNameField.delegate = self;
    self.passwordField.delegate = self;
    
    SettingsController *settingsController = [[SettingsController alloc] init];
    [[settingsController fetchedResultsController] fetchRequest];
    
    NSError *error;
    if (![settingsController.fetchedResultsController performFetch:&error]) {
        NSLog(@"Fetch error: %@", error);
    }
    
    self.settings = settingsController.fetchedResultsController.fetchedObjects[0];
    
    [self customizeViews];
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

- (NSString *)stringByDistanceType:(NSInteger)type {
    
    if (type == 1)
        return @"Kilometers";
    else
        return @"Miles";
}

- (NSInteger)distanceTypeByString:(NSString *)string {
    
    if ([string isEqualToString:@"Kilometers"])
        return 1;
    else
        return 2;
}

- (void)customizeViews {
    
    self.userNameEditView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pencil-button"]];
    self.passwordEditView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pencil-button"]];
    self.selectView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"arrow-button"]];
        
    self.saveButton.layer.cornerRadius = 5.0;
    
    self.userNameField.text = self.settings.userName;
    self.passwordField.text = self.settings.password;
    self.distanceLabel.text = [self stringByDistanceType:self.settings.distanceType.intValue];
}

- (IBAction)saveButtonClick:(id)sender {
    
    self.settings.userName = self.userNameField.text;
    self.settings.password = self.passwordField.text;
    self.settings.distanceType = [NSNumber numberWithInt:[self distanceTypeByString:self.distanceLabel.text]];
    
    [[StorageController sharedController] saveContext];
    
    [GlobalSettings sharedManager].isMiles = ([self.distanceLabel.text isEqualToString:@"Kilometers"])?NO:YES;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

- (IBAction)choiceButtonClick:(id)sender {
    
    [self.view addSubview:self.kilometersButton];
    [self.view addSubview:self.milesButton];
    self.kilometersButton.hidden = NO;
    self.milesButton.hidden = NO;
}

- (IBAction)kilometersButtonClick:(id)sender {
    
    self.distanceLabel.text = @"Kilometers";
    self.kilometersButton.hidden = YES;
    self.milesButton.hidden = YES;
}

- (IBAction)milesButtonClick:(id)sender {
    
    self.distanceLabel.text = @"Miles";
    self.kilometersButton.hidden = YES;
    self.milesButton.hidden = YES;
}

#pragma mark - Text Field Delegate method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

@end
