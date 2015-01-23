//
//  SearchViewController.m
//  AppName
//
//  Created by Sanny on 19.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import "SearchViewController.h"
#import "ProductViewController.h"
#import "Settings.h"
#import "SettingsController.h"
#import "ProductController.h"
#import "CustomProduct.h"

@interface SearchViewController ()

@property (nonatomic, strong) UIButton *revealButton;
@property (nonatomic, strong) NSMutableArray *productsArray;
@property (nonatomic, strong) NSMutableArray *searchResultArray;

@property (nonatomic, strong) UITableView *productTypesTableView;
@property (nonatomic, strong) UITableView *parametersTableView;
@property (nonatomic, strong) UITableView *sortTableView;
@property (nonatomic, strong) NSArray *arrayOfPopupItems;
@property (nonatomic, assign) NSInteger popupType;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [GlobalSettings sharedManager].isMiles = NO;
    if (![GlobalSettings sharedManager].wishList)
        [GlobalSettings sharedManager].wishList = [[NSMutableArray alloc] init];
    [[GlobalSettings sharedManager] createProductsArray];
    
    self.title = @"Search";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.textField.delegate = self;
    
    SWRevealViewController *revealController = [self revealViewController];
    revealController.delegate = self;
    [revealController tapGestureRecognizer];

    self.revealButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 43, 35)];
    [self.revealButton setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateNormal];
    [self.revealButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.revealButton];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self customizeViews];
    [self setupGlobalSettings];
    [self customizeSwipeGestureRecognize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.revealButton.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.revealButton.hidden = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setupGlobalSettings {
    
    SettingsController *settingsController = [[SettingsController alloc] init];
    [[settingsController fetchedResultsController] fetchRequest];
    
    NSError *error;
    if (![settingsController.fetchedResultsController performFetch:&error]) {
        NSLog(@"Fetch error: %@", error);
    }
    
    Settings *settings = settingsController.fetchedResultsController.fetchedObjects[0];
    
    [GlobalSettings sharedManager].isMiles = (settings.distanceType.intValue == 1)?NO:YES;
}

- (void)customizeViews {
    
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.popupTableView.delegate = self;
    self.popupTableView.dataSource = self;
    self.popupTableView.layer.borderWidth = 1.0;
    self.popupTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.popupTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.popupTableView.scrollEnabled = NO;
}

- (void)createSearchResult {
    
    NSString *searchQuery = self.textField.text;
    self.searchResultArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [GlobalSettings sharedManager].productsArray.count; i++) {
        
        Product *product = [GlobalSettings sharedManager].productsArray[i];
        if ([product.productName rangeOfString:searchQuery].location != NSNotFound)
            [self.searchResultArray addObject:product];
    }
    
    [self.tableView reloadData];
}

- (NSString *)createDistanceString:(CGFloat)distance {
    
    return [GlobalSettings sharedManager].isMiles?[NSString stringWithFormat:@"%.1f miles", distance]:[NSString stringWithFormat:@"%.1f kilometers", distance*1.609];
}

- (void)customizeSwipeGestureRecognize {
    
    UISwipeGestureRecognizer *showExtrasSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipe:)];
    showExtrasSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:showExtrasSwipe];
}

- (BOOL)isProductInWishList:(CustomProduct *)product {
    
    ProductController *productController = [[ProductController alloc] init];
    [[productController fetchedResultsController] fetchRequest];
    
    NSError *error;
    if (![productController.fetchedResultsController performFetch:&error]) {
        NSLog(@"Fetch error: %@", error);
    }
    
    NSArray *productsArray = productController.fetchedResultsController.fetchedObjects;
    
    for (int i = 0; i < productsArray.count; i++) {
        Product *wishListProduct = productsArray[i];
        if (product.productId.intValue == wishListProduct.productId.intValue)
            return YES;
    }
    
    return NO;
}

- (void)actionWithDelay:(double)delay completion:(void (^)())completion{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), completion);
}

- (void)cellSwipe:(UISwipeGestureRecognizer *)gesture {
    
    if (self.searchResultArray.count > 0) {
        CGPoint location = [gesture locationInView:self.tableView];
        NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
        
        NSLog(@"indexpath.row: %d, count: %d, location.y: %f", swipedIndexPath.row, self.searchResultArray.count, location.y);
        if (location.y < 70*self.searchResultArray.count) {
            CustomProduct *product = self.searchResultArray[swipedIndexPath.row];
            if (![self isProductInWishList:product]) {
                
                ProductController *productController = [[ProductController alloc] init];
                [productController writeProductWithId:product.productId name:product.productName rating:product.rating type:product.type distance:product.distance creatorName:product.creatorName parameter1:product.parameter1 parameter2:product.parameter2 parameter3:product.parameter3 creationDate:product.creationDate];
                
                [self.searchResultArray removeObject:product];
                
                [self.tableView beginUpdates];
                [self.tableView deleteRowsAtIndexPaths:@[swipedIndexPath] withRowAnimation:UITableViewRowAnimationRight];
                [self.tableView endUpdates];
                [self actionWithDelay:0.3 completion:^() {
                    [self.tableView reloadData];
                }];
            } else {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"This product already in wish list" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
        }
    }
}

#pragma mark - Text Field Delegate method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self createSearchResult];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Table View Delegate & DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [tableView isEqual:self.tableView]?self.searchResultArray.count:self.arrayOfPopupItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [tableView isEqual:self.tableView]?70.0:40.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = nil;
    
    if ([tableView isEqual:self.tableView]) {

        CustomProduct *product = self.searchResultArray[indexPath.row];

        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *customImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
        customImage.image = [UIImage imageNamed:@"product-logo.gif"];
        [cell addSubview:customImage];
        
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 150, 15)];
        userNameLabel.text = product.creatorName;
        userNameLabel.textColor = [UIColor colorWithRed:0.494 green:0.506 blue:0.498 alpha:1];
        userNameLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:userNameLabel];
        
        UILabel *productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 150, 20)];
        productNameLabel.text = product.productName;
        productNameLabel.textColor = [UIColor colorWithRed:0.494 green:0.506 blue:0.498 alpha:1];
        productNameLabel.font = [UIFont systemFontOfSize:14];
        [cell addSubview:productNameLabel];
        
        UIImageView *locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 40, 14, 20)];
        locationImageView.image = [UIImage imageNamed:@"location-icon"];
        [cell addSubview:locationImageView];
        
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, 130, 20)];
        locationLabel.text = [self createDistanceString:product.distance.floatValue];
        locationLabel.textColor = [UIColor colorWithRed:0.494 green:0.506 blue:0.498 alpha:1];
        locationLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:locationLabel];
        
        UIView *ratingView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.size.width-60, 10, 50, 50)];
        ratingView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rating-background"]];
        [cell addSubview:ratingView];
        
        UILabel *ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];\
        ratingLabel.text = [NSString stringWithFormat:@"%.1f", product.rating.floatValue];
        ratingLabel.textColor = [UIColor whiteColor];
        ratingLabel.font = [UIFont systemFontOfSize:20];
        ratingLabel.textAlignment = NSTextAlignmentCenter;
        [ratingView addSubview:ratingLabel];
        
        if (indexPath.row % 2 == 0)
            cell.backgroundColor = [UIColor colorWithRed:0.914 green:0.922 blue:0.918 alpha:1];
    } else {

        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = self.arrayOfPopupItems[indexPath.row];
    }


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:self.tableView]) {
        ProductViewController *productController = [[ProductViewController alloc] init];
        productController.product = self.searchResultArray[indexPath.row];
        [self.navigationController pushViewController:productController animated:YES];
    } else {
        
        self.popupTableView.hidden = YES;
        NSMutableArray *temporaryArray = [[NSMutableArray alloc] init];
        
        NSInteger count = self.searchResultArray.count;
        for (int i = 0; i < count; i++) {
            
            CustomProduct *product = self.searchResultArray[i];
            
            if (self.popupType == 1) {
                
                if (product.type.intValue == indexPath.row+1)
                    [temporaryArray addObject:product];
            } else if (self.popupType == 2) {
                
                if ([product.parameter1 isEqualToString:self.arrayOfPopupItems[indexPath.row]] || [product.parameter2 isEqualToString:self.arrayOfPopupItems[indexPath.row]] || [product.parameter3 isEqualToString:self.arrayOfPopupItems[indexPath.row]])
                    [temporaryArray addObject:product];
            } else {
                
                if (product.distance.floatValue > indexPath.row && product.distance.floatValue < indexPath.row+1)
                    [temporaryArray addObject:product];
            }
        }
        
        self.searchResultArray = temporaryArray;
        [self.tableView reloadData];
    }
}

- (IBAction)leftSearchButtonClick:(id)sender {
    
    self.popupType = 1;
    self.arrayOfPopupItems = @[@"Product type 1", @"Product type 2", @"Product type 3", @"Product type 4", @"Product type 5", @"Product type 6"];
    self.popupTableView.frame = CGRectMake(10, 120, 150, self.arrayOfPopupItems.count*40);
    self.popupTableView.hidden = NO;
    [self.popupTableView reloadData];
}

- (IBAction)rightSearchButtonClick:(id)sender {
    
    self.popupType = 2;
    self.arrayOfPopupItems = @[@"Value1", @"Value2", @"Value3", @"Value4", @"Value5", @"Value6"];
    self.popupTableView.frame = CGRectMake(115, 120, 150, self.arrayOfPopupItems.count*40);
    self.popupTableView.hidden = NO;
    [self.popupTableView reloadData];
}

- (IBAction)sortButtonClick:(id)sender {
    
    self.popupType = 3;
    self.arrayOfPopupItems = @[@"< 1 miles", @"1 - 2 miles", @"2 - 3 miles", @"3 - 4 miles"];
    self.popupTableView.frame = CGRectMake(160, 120, 150, self.arrayOfPopupItems.count*40);
    self.popupTableView.hidden = NO;
    [self.popupTableView reloadData];
}
@end
