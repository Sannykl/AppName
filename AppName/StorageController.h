//
//  StorageController.h
//  AppName
//
//  Created by Sanny on 19.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface StorageController : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedController;
- (void)saveContext;
- (void)reset;

@end
