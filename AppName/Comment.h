//
//  Comment.h
//  AppName
//
//  Created by Sanny on 21.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * msgText;
@property (nonatomic, retain) NSString * postDate;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) Product *product;

@end
