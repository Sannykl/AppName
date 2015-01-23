//
//  CommentsViewController.m
//  AppName
//
//  Created by Sanny on 20.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentsController.h"

@interface CommentsViewController (){
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGFloat nextMessagePointY;
}

@property (nonatomic, strong) UIImageView *chatIcon;
@property (nonatomic, strong) NSMutableArray *commentsArray;
@property (nonatomic, strong) NSString *adminMessage;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"COMMENTS";
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    nextMessagePointY = 0.0;
    self.adminMessage = @"This question has been asked before and already has an answer. If those answers do not fully address your question, please ask a new question.";
    
    CommentsController *commentsController = [[CommentsController alloc] init];
    [[commentsController fetchedResultsController] fetchRequest];
    
    NSError *error;
    if (![commentsController.fetchedResultsController performFetch:&error]) {
        NSLog(@"Fetch error: %@", error);
    }
    
    [self createCommentsArray:commentsController];
    
    [self customizeViews];
    
    self.scrollView.delegate = self;
    self.textView.delegate = self;
    
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

- (void)customizeViews {
    
    UIImageView *photoView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 20.0, 59.0, 59.0)];
    photoView.image = [UIImage imageNamed:@"product-logo.gif"];
    [self.topPanel addSubview:photoView];
    
    UILabel *plantNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 30.0, 150.0, 20.0)];
    plantNameLabel.text = @"Plant name:";
    plantNameLabel.font = [UIFont systemFontOfSize:12];
    plantNameLabel.textColor = [UIColor colorWithRed:0.494 green:0.506 blue:0.498 alpha:1];
    [self.topPanel addSubview:plantNameLabel];
    
    UILabel *productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 45.0, 230.0, 20)];
    productNameLabel.text = self.product.productName;
    productNameLabel.font = [UIFont systemFontOfSize:16];
    productNameLabel.textColor = [UIColor colorWithRed:0.494 green:0.506 blue:0.498 alpha:1];
    [self.topPanel addSubview:productNameLabel];
    
    self.chatIcon = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-56.0, 80.0, 41, 41)];
    self.chatIcon.image = [UIImage imageNamed:@"chat-icon"];
    [self.view addSubview:self.chatIcon];
    
    self.bottomPanel = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight-141, screenWidth, 77)];
    self.bottomPanel.backgroundColor = [UIColor colorWithRed:0.953 green:0.953 blue:0.953 alpha:1];
    [self.view addSubview:self.bottomPanel];
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, screenWidth-120, 57)];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.layer.cornerRadius = 3.0;
    self.textView.returnKeyType = UIReturnKeyDone;
    [self.bottomPanel addSubview:self.textView];
    self.sendButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth-100, 10, 90, 57)];
    self.sendButton.backgroundColor = [UIColor darkGrayColor];
    self.sendButton.layer.cornerRadius = 3.0;
    [self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomPanel addSubview:self.sendButton];
    
    [self createMessageObjects];
}

- (void)createCommentsArray:(CommentsController *)commentsController {
    
    self.commentsArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < commentsController.fetchedResultsController.fetchedObjects.count; i++) {
        
        Comment *comment = commentsController.fetchedResultsController.fetchedObjects[i];
        
        if ([comment.product.productName isEqualToString:self.product.productName]) {
            [self.commentsArray addObject:comment];
        }
    }
}

- (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGFloat result = font.pointSize+4;
    if (text) {
        CGSize size;
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height+1);
        result = MAX(size.height, result); //At least one row
    }
    return result;
}

- (void)createMessageObjects {
    
    NSInteger counts = self.commentsArray.count - 1;
    for (int i = counts; i > -1 ; i--) {
        
        Comment *comment = self.commentsArray[i];
        CGFloat textHeight = [self findHeightForText:comment.msgText havingWidth:200 andFont:[UIFont systemFontOfSize:12]];
        
        if (comment.type.intValue == 1) {
            
            UILabel *dateLabel = [[UILabel alloc] init];
            dateLabel.frame = CGRectMake(15, nextMessagePointY + 20, 150, 10);
            dateLabel.text = comment.postDate;
            dateLabel.font = [UIFont systemFontOfSize:10];
            dateLabel.backgroundColor = [UIColor clearColor];
            dateLabel.textColor = [UIColor darkGrayColor];
            [self.scrollView addSubview:dateLabel];
            
            UITextView *textView = [[UITextView alloc] init];
            textView.frame = CGRectMake(10, nextMessagePointY + 30, 220, textHeight+20);
            textView.text = comment.msgText;
            textView.backgroundColor = [UIColor colorWithRed:0.882 green:0.251 blue:0.322 alpha:1];
            textView.layer.cornerRadius = 5.0;
            textView.textColor = [UIColor whiteColor];
            textView.editable = NO;
            textView.selectable = NO;
            nextMessagePointY += (textHeight + 40);
            self.scrollView.contentSize = CGSizeMake(screenWidth, nextMessagePointY);
            [self.scrollView addSubview:textView];
        } else {
            
            UILabel *dateLabel = [[UILabel alloc] init];
            dateLabel.frame = CGRectMake(screenWidth-225, nextMessagePointY + 20, 150, 10);
            dateLabel.font = [UIFont systemFontOfSize:10];
            dateLabel.text = comment.postDate;
            dateLabel.backgroundColor = [UIColor clearColor];
            dateLabel.textColor = [UIColor darkGrayColor];
            [self.scrollView addSubview:dateLabel];
            
            UITextView *textView = [[UITextView alloc] init];
            textView.frame = CGRectMake(screenWidth-230, nextMessagePointY + 30, 220, textHeight+20);
            textView.text = comment.msgText;
            textView.layer.cornerRadius = 5.0;
            textView.backgroundColor = [UIColor lightGrayColor];
            textView.textColor = [UIColor darkGrayColor];
            textView.editable = NO;
            textView.selectable = NO;
            nextMessagePointY += (textHeight + 40);
            self.scrollView.contentSize = CGSizeMake(screenWidth, nextMessagePointY);
            [self.scrollView addSubview:textView];
        }
    }
}

- (void)addNewCommentWithType:(NSInteger)type {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    
    if (type == 1) {
        
        CGFloat textHeight = [self findHeightForText:self.textView.text havingWidth:200 andFont:[UIFont systemFontOfSize:12]];

        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.frame = CGRectMake(15, nextMessagePointY + 20, 150, 10);
        dateLabel.text = [dateFormat stringFromDate:[NSDate date]];
        dateLabel.font = [UIFont systemFontOfSize:10];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.textColor = [UIColor darkGrayColor];
        [self.scrollView addSubview:dateLabel];
        
        UITextView *textView = [[UITextView alloc] init];
        textView.frame = CGRectMake(10, nextMessagePointY + 30, 220, textHeight+20);
        textView.text = self.textView.text;
        textView.backgroundColor = [UIColor colorWithRed:0.882 green:0.251 blue:0.322 alpha:1];
        textView.textColor = [UIColor whiteColor];
        textView.layer.cornerRadius = 5.0;
        textView.editable = NO;
        textView.selectable = NO;
        nextMessagePointY += (textHeight + 40);
        self.scrollView.contentSize = CGSizeMake(screenWidth, nextMessagePointY);
        [self.scrollView addSubview:textView];
    } else {
        
        CGFloat textHeight = [self findHeightForText:self.adminMessage havingWidth:200 andFont:[UIFont systemFontOfSize:12]];

        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.frame = CGRectMake(screenWidth-225, nextMessagePointY + 20, 150, 10);
        dateLabel.text = [dateFormat stringFromDate:[NSDate date]];
        dateLabel.font = [UIFont systemFontOfSize:10];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.textColor = [UIColor darkGrayColor];
        [self.scrollView addSubview:dateLabel];
        
        UITextView *textView = [[UITextView alloc] init];
        textView.frame = CGRectMake(screenWidth-230, nextMessagePointY + 30, 220, textHeight+20);
        textView.text = self.adminMessage;
        textView.layer.cornerRadius = 5.0;
        textView.backgroundColor = [UIColor lightGrayColor];
        textView.textColor = [UIColor darkGrayColor];
        textView.editable = NO;
        textView.selectable = NO;
        nextMessagePointY += (textHeight + 40);
        self.scrollView.contentSize = CGSizeMake(screenWidth, nextMessagePointY);
        [self.scrollView addSubview:textView];
    }
}

- (void)createSmallerViews {
    
    [UIView animateWithDuration:0.4 animations:^() {
        self.bottomPanel.frame = CGRectMake(0, 202, screenWidth, 77);
    }];
}

- (void)createNormalViews {
    
    [UIView animateWithDuration:0.4 animations:^() {
        self.bottomPanel.frame = CGRectMake(0, screenHeight-141, screenWidth, 77);
    }];
}

- (void)actionWithDelay:(double)delay completion:(void (^)())completion{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), completion);
}

#pragma mark - Text View Delegate methods

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [self createSmallerViews];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self createNormalViews];
    }
    
    return YES;
}

- (void)sendButtonClick:(id)sender {
    
    CommentsController *commentsController = [[CommentsController alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    [commentsController writeMessageText:self.textView.text postDate:[dateFormat stringFromDate:[NSDate date]] withType:1 forProduct:self.product];
    [self addNewCommentWithType:1];
    [self createNormalViews];
    [self.textView resignFirstResponder];
    self.textView.text = @"";
    
    
    [self actionWithDelay:10.0 completion:^() {
        [commentsController writeMessageText:self.adminMessage postDate:[dateFormat stringFromDate:[NSDate date]] withType:2 forProduct:self.product];
        [self addNewCommentWithType:2];
    }];
}

@end
