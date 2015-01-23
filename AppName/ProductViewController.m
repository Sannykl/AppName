//
//  ProductViewController.m
//  AppName
//
//  Created by Sanny on 20.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import "ProductViewController.h"
#import "GlobalSettings.h"

@interface ProductViewController (){
    CGFloat screenWidth;
    CGFloat screenHeight;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isTableViewVisible;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.product.productName;
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.isTableViewVisible = NO;
    
    [self customizeViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeViews {
    
    self.productLabel.text = self.product.productName;
    
    self.scrollView.contentSize = CGSizeMake(390.0, 78);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < 5; i++) {
        
        [self.scrollView addSubview:[self createCriterionViewWithId:i]];
    }
    
    UILabel *ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
    ratingLabel.textAlignment = NSTextAlignmentCenter;
    ratingLabel.textColor = [UIColor whiteColor];
    ratingLabel.font = [UIFont systemFontOfSize:14];
    ratingLabel.text = [NSString stringWithFormat:@"%.1f", self.product.rating.floatValue];
    [self.ratingView addSubview:ratingLabel];
    
    self.topBottomButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"to-top-button"]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, 350.0)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    
}

- (NSString *)createDistanceString:(CGFloat)distance {
    
    return [GlobalSettings sharedManager].isMiles?[NSString stringWithFormat:@"%.1f miles", distance]:[NSString stringWithFormat:@"%.1f kilometers", distance*1.609];
}

- (UIView *)createCriterionViewWithId:(NSInteger)index {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(78*index, 0, 78, 78)];
    
    UILabel *digitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 78, 40)];
    digitLabel.text = @"5";
    digitLabel.font = [UIFont systemFontOfSize:20];
    digitLabel.textColor = [UIColor whiteColor];
    digitLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview: digitLabel];
    
    UILabel *criterionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 78, 20)];
    criterionLabel.text = [NSString stringWithFormat:@"Criterion %d", index+1];
    criterionLabel.font = [UIFont systemFontOfSize:14];
    criterionLabel.textColor = [UIColor whiteColor];
    criterionLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:criterionLabel];
    
    switch (index) {
        case 0:
            view.backgroundColor = [UIColor colorWithRed:0.686 green:0.808 blue:0.525 alpha:1];
            break;
            
        case 1:
            view.backgroundColor = [UIColor colorWithRed:0.553 green:0.702 blue:0.357 alpha:1];
            break;
            
        case 2:
            view.backgroundColor = [UIColor colorWithRed:0.42 green:0.576 blue:0.216 alpha:1];
            break;
            
        case 3:
            view.backgroundColor = [UIColor colorWithRed:0.306 green:0.455 blue:0.11 alpha:1];
            break;
            
        case 4:
            view.backgroundColor = [UIColor colorWithRed:0.224 green:0.361 blue:0.047 alpha:1];
            break;
            
        default:
            break;
    }
    
    return view;
}

- (void)actionWithDelay:(double)delay completion:(void (^)())completion{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), completion);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)starButtonClick:(id)sender {
}

- (IBAction)toTopButtonClick:(id)sender {
    
    if (!self.isTableViewVisible) {
        
        [UIView animateWithDuration:0.5 animations:^() {
            self.tableView.frame = CGRectMake(0, screenHeight-264, screenWidth, 200);
            self.scrollView.frame = CGRectMake(0, screenHeight-342, screenWidth, 78);
            self.imageView.frame = CGRectMake(0, 0, screenWidth, screenHeight-342);
            self.plantLabel.frame = CGRectMake(8, screenHeight-392, 87, 21);
            self.productLabel.frame = CGRectMake(8, screenHeight-378, 169, 21);
            self.topBottomButton.frame = CGRectMake(screenWidth-64, screenHeight-402, 49, 49);
        }];
        [self actionWithDelay:0.5 completion:^() {
            self.isTableViewVisible = YES;
//            [self.topBottomButton setImage:[UIImage imageNamed:@"to-bottom-button"] forState:UIControlStateNormal];
            self.topBottomButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"to-bottom-button"]];
        }];
    } else {
        
        [UIView animateWithDuration:0.5 animations:^() {
            self.tableView.frame = CGRectMake(0, screenHeight, screenWidth, 200);
            self.scrollView.frame = CGRectMake(0, screenHeight-142, screenWidth, 78);
            self.imageView.frame = CGRectMake(0, 0, screenWidth, screenHeight-142);
            self.plantLabel.frame = CGRectMake(8, 366, 87, 21);
            self.productLabel.frame = CGRectMake(8, 390, 169, 21);
            self.topBottomButton.frame = CGRectMake(screenWidth-64, 364, 49, 49);
        }];
        [self actionWithDelay:0.5 completion:^() {
            self.isTableViewVisible = NO;
//            [self.topBottomButton setImage:[UIImage imageNamed:@"to-top-button"] forState:UIControlStateNormal];
            self.topBottomButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"to-top-button"]];
        }];
    }
}

#pragma mark - Table View Delegate & DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = nil;
        
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0, cell.frame.size.height-1.0, cell.frame.size.width, 1.0);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [cell.layer addSublayer:bottomBorder];
    cell.backgroundColor = [UIColor whiteColor];
    
    UIImageView *customImage = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth - 35.0, 9.0, 30.0, 30.0)];
    customImage.image = [UIImage imageNamed:@"parameter-icon"];
    [cell addSubview:customImage];
    
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Type:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f", self.product.type.floatValue];
            break;
            
        case 1:
            cell.textLabel.text = @"Distance:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self createDistanceString:self.product.distance.floatValue]];
            break;
            
        case 2:
            cell.textLabel.text = @"Parameter:";
            cell.detailTextLabel.text = self.product.parameter1;
            break;

        case 3:
            cell.textLabel.text = @"Parameter:";
            cell.detailTextLabel.text = self.product.parameter2;
            break;

        case 4:
            cell.textLabel.text = @"Parameter:";
            cell.detailTextLabel.text = self.product.parameter3;
            break;

        default:
            break;
    }

    return cell;
}

@end
