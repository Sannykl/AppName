//
//  ProductController.m
//  AppName
//
//  Created by Sanny on 21.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import "ProductController.h"

@implementation ProductController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize product = _product;

- (void)reset {
    
    self.fetchedResultsController = nil;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product"
                                              inManagedObjectContext:[StorageController sharedController].managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"productName"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[StorageController sharedController].managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    return _fetchedResultsController;
}

- (void)writeProductWithId:(NSNumber *)productId
                      name:(NSString *)productName
                    rating:(NSNumber *)rating
                      type:(NSNumber *)type
                  distance:(NSNumber *)distance
               creatorName:(NSString *)name
                parameter1:(NSString *)parameter1
                parameter2:(NSString *)parameter2
                parameter3:(NSString *)parameter3
              creationDate:(NSString *)creationDate{
    
    NSManagedObjectContext *context = [[StorageController sharedController] managedObjectContext];
    _product = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Product class])
                                              inManagedObjectContext:context];
    
    _product.productId = productId;
    _product.productName = productName;
    _product.rating = rating;
    _product.type = type;
    _product.distance = distance;
    _product.creatorName = name;
    _product.parameter1 = parameter1;
    _product.parameter2 = parameter2;
    _product.parameter3 = parameter3;
    _product.creationDate = creationDate;
    
    [[StorageController sharedController] saveContext];
}

- (void)removeProductFromWishList:(Product *)product {
    
    NSManagedObjectContext *context = [StorageController sharedController].managedObjectContext;
    [context deleteObject:product];
    [[StorageController sharedController] saveContext];
}

- (void)reloadFetchResult {
    
    NSFetchRequest *fetchRequest = self.fetchedResultsController.fetchRequest;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"productName" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"ERROR performing fetch: %@, %@", error, [error userInfo]);
    }
}

@end
