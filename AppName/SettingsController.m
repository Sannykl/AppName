//
//  SettingsController.m
//  AppName
//
//  Created by Sanny on 19.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import "SettingsController.h"

@implementation SettingsController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize settings = _settings;

- (void)reset {
    
    self.fetchedResultsController = nil;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Settings"
                                              inManagedObjectContext:[StorageController sharedController].managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"userName"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[StorageController sharedController].managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    return _fetchedResultsController;
}

- (void)writeUserName:(NSString *)userName password:(NSString *)password {
    
    NSManagedObjectContext *context = [[StorageController sharedController] managedObjectContext];
    _settings = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Settings class])
                                          inManagedObjectContext:context];
    
    _settings.userName = userName;
    _settings.password = password;
    _settings.distanceType = [NSNumber numberWithInt:1];
    
    [[StorageController sharedController] saveContext];
}

- (void)deleteSettings:(Settings *)settings {
    
    if (settings != nil) {
        NSManagedObjectContext *context = [StorageController sharedController].managedObjectContext;
        [context deleteObject:settings];
        
        [[StorageController sharedController] saveContext];
    }
}

- (void)reloadFetchResult {
    
    NSFetchRequest *fetchRequest = self.fetchedResultsController.fetchRequest;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"ERROR performing fetch: %@, %@", error, [error userInfo]);
    }
}

@end
