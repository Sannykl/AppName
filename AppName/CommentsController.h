//
//  CommentsController.h
//  AppName
//
//  Created by Sanny on 21.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Comment.h"
#import "Product.h"
#import "StorageController.h"

@interface CommentsController : NSObject

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) Comment *comment;

- (void)reset;
- (void)writeMessageText:(NSString *)messageText postDate:(NSString *)postDate withType:(NSInteger)type forProduct:(Product *)product;
- (void)removeComment:(Comment *)comment;
- (void)reloadFetchResult;

@end
