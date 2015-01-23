//
//  ProductViewController.h
//  AppName
//
//  Created by Sanny on 20.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *ratingView;
@property (weak, nonatomic) IBOutlet UIButton *starButton;
@property (weak, nonatomic) IBOutlet UIButton *topBottomButton;
@property (weak, nonatomic) IBOutlet UILabel *plantLabel;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) Product *product;

- (IBAction)starButtonClick:(id)sender;
- (IBAction)toTopButtonClick:(id)sender;

@end
