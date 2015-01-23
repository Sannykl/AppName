//
//  ProductController.h
//  AppName
//
//  Created by Sanny on 21.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Product.h"
#import "StorageController.h"

@interface ProductController : NSObject

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) Product *product;

- (void)reset;
- (void)writeProductWithId:(NSNumber *)productId name:(NSString *)productName rating:(NSNumber *)rating type:(NSNumber *)type distance:(NSNumber *)distance creatorName:(NSString *)name parameter1:(NSString *)parameter1 parameter2:(NSString *)parameter2 parameter3:(NSString *)parameter3 creationDate:(NSString *)creationDate;
- (void)reloadFetchResult;
- (void)removeProductFromWishList:(Product *)product;

@end
