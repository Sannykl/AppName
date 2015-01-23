//
//  CommentsController.m
//  AppName
//
//  Created by Sanny on 21.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import "CommentsController.h"

@implementation CommentsController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize comment = _comment;

- (void)reset {
    
    self.fetchedResultsController = nil;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Comment"
                                              inManagedObjectContext:[StorageController sharedController].managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"postDate"
                                                                   ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[StorageController sharedController].managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    return _fetchedResultsController;
}

- (void)writeMessageText:(NSString *)messageText postDate:(NSString *)postDate withType:(NSInteger)type forProduct:(Product *)product{
    
    NSManagedObjectContext *context = [[StorageController sharedController] managedObjectContext];
    _comment = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Comment class])
                                             inManagedObjectContext:context];
    
    _comment.msgText = messageText;
    _comment.postDate = postDate;
    _comment.product = product;
    _comment.type = [NSNumber numberWithInt:type];//1 - user's message, 2 - admin's message
    
    [[StorageController sharedController] saveContext];
}

- (void)removeComment:(Comment *)comment {
    
    NSManagedObjectContext *context = [StorageController sharedController].managedObjectContext;
    [context deleteObject:comment];
    [[StorageController sharedController] saveContext];
}

- (void)reloadFetchResult {
    
    NSFetchRequest *fetchRequest = self.fetchedResultsController.fetchRequest;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"postDate" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"ERROR performing fetch: %@, %@", error, [error userInfo]);
    }
}

@end
