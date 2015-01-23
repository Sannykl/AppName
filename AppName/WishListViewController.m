//
//  WishListViewController.m
//  AppName
//
//  Created by Sanny on 20.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import "WishListViewController.h"
#import "GlobalSettings.h"
#import "CommentsViewController.h"
#import "ProductViewController.h"
#import "ProductController.h"
#import "Product.h"
#import "Comment.h"
#import "CommentsController.h"


@interface WishListViewController ()

@property (nonatomic, strong) UIButton *revealButton;
@property (nonatomic, strong) NSMutableArray *productsArray;
@property (nonatomic, strong) NSArray *allComments;
@property (nonatomic, strong) CommentsController *commentsController;

@end

@implementation WishListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"WISH LIST";

    ProductController *productController = [[ProductController alloc] init];
    [[productController fetchedResultsController] fetchRequest];
    
    NSError *error;
    if (![productController.fetchedResultsController performFetch:&error]) {
        NSLog(@"Fetch error: %@", error);
    }
    
    self.productsArray = [NSMutableArray arrayWithArray:productController.fetchedResultsController.fetchedObjects];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

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
    [self customizeSwipeGestureRecognize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.revealButton.hidden = NO;
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.revealButton.hidden = YES;
}

- (void)customizeViews {
    
    [self.tableView setShowsVerticalScrollIndicator:NO];
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

- (void)customizeSwipeGestureRecognize {
    
    UISwipeGestureRecognizer *showExtrasSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipe:)];
    showExtrasSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.tableView addGestureRecognizer:showExtrasSwipe];
}

- (void)cellSwipe:(UISwipeGestureRecognizer *)gesture {

    CGPoint location = [gesture locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];

    if (location.y < 70*self.productsArray.count) {
        
        Product *product = self.productsArray[swipedIndexPath.row];
        [self.productsArray removeObject:product];
        
        ProductController *productController = [[ProductController alloc] init];
        [productController removeProductFromWishList:product];
        
        for (int i = 0; i < self.allComments.count; i++) {
            
            Comment *comment = self.allComments[i];
            if ([comment.product isEqual:product])
                [self.commentsController removeComment:comment];
        }
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[swipedIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
        [self actionWithDelay:0.3 completion:^() {
            [self.tableView reloadData];
        }];
    }
}

- (void)actionWithDelay:(double)delay completion:(void (^)())completion{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), completion);
}

- (void)commentButtonClick:(UIButton *)sender {
    
    CommentsViewController *commentsController = [[CommentsViewController alloc] init];
    
    CGPoint location = [sender convertPoint:sender.frame.origin toView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:CGPointMake(100, location.y)];
    commentsController.product = self.productsArray[indexPath.row];
    NSLog(@"Name: %@", commentsController.product.productName);
    [self.navigationController pushViewController:commentsController animated:YES];
}

- (NSInteger)commentsCountWithProduct:(Product *)product {
    
    NSInteger count = 0;
    
    self.commentsController = [[CommentsController alloc] init];
    [[self.commentsController fetchedResultsController] fetchRequest];
    
    NSError *error;
    if (![self.commentsController.fetchedResultsController performFetch:&error]) {
        NSLog(@"Fetch error: %@", error);
    }
    
    self.allComments = self.commentsController.fetchedResultsController.fetchedObjects;
    
    for (int i = 0; i < self.commentsController.fetchedResultsController.fetchedObjects.count; i++) {
        
        if ([product.comments containsObject:self.commentsController.fetchedResultsController.fetchedObjects[i]]) {
            
            count++;
        }
    }
    
    return count;
}

#pragma mark - Table View Delegate & DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.productsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = nil;
    
    Product *product = self.productsArray[indexPath.row];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *customImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
    customImage.image = [UIImage imageNamed:@"product-logo.gif"];
    [cell addSubview:customImage];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 150, 15)];
    dateLabel.text = product.creationDate;
    dateLabel.textColor = [UIColor colorWithRed:0.494 green:0.506 blue:0.498 alpha:1];
    dateLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:dateLabel];
    
    UILabel *plantNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 150, 20)];
    plantNameLabel.text = @"Plant name:";
    plantNameLabel.textColor = [UIColor colorWithRed:0.494 green:0.506 blue:0.498 alpha:1];
    plantNameLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:plantNameLabel];
    
    UILabel *productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 130, 20)];
    productNameLabel.text = product.productName;
    productNameLabel.textColor = [UIColor colorWithRed:0.494 green:0.506 blue:0.498 alpha:1];
    productNameLabel.font = [UIFont systemFontOfSize:14];
    [cell addSubview:productNameLabel];
    
    UIButton *countButton = [[UIButton alloc] initWithFrame:CGRectMake(cell.frame.size.width-46, 20, 35, 30)];
    NSInteger commentsCount = [self commentsCountWithProduct:product];
    if (commentsCount > 0)
        countButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"comments-count-background"]];
    else
        countButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray-comments-count-background"]];
    [countButton addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:countButton];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 25)];
    countLabel.text = [NSString stringWithFormat:@"%d", commentsCount];
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.font = [UIFont systemFontOfSize:14];
    countLabel.textColor = [UIColor whiteColor];
    [countButton addSubview:countLabel];
    
    if (indexPath.row % 2 == 0)
        cell.backgroundColor = [UIColor colorWithRed:0.914 green:0.922 blue:0.918 alpha:1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductViewController *productController = [[ProductViewController alloc] init];
    productController.product = self.productsArray[indexPath.row];
    [self.navigationController pushViewController:productController animated:YES];
}

@end
