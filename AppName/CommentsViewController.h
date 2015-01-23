//
//  CommentsViewController.h
//  AppName
//
//  Created by Sanny on 20.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface CommentsViewController : UIViewController <UIScrollViewDelegate, UITextViewDelegate>

@property (nonatomic, assign) CGFloat contentHeight;
@property (weak, nonatomic) IBOutlet UIView *topPanel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIView *bottomPanel;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) Product *product;

@end
