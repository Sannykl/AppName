//
//  SettingsController.h
//  AppName
//
//  Created by Sanny on 19.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Settings.h"
#import "StorageController.h"

@interface SettingsController : NSObject

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) Settings *settings;

- (void)reset;
- (void)writeUserName:(NSString *)userName password:(NSString *)password;
- (void)deleteSettings:(Settings *)settings;
- (void)reloadFetchResult;

@end
