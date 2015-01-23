//
//  Product.h
//  AppName
//
//  Created by Sanny on 21.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * creatorName;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * parameter1;
@property (nonatomic, retain) NSString * parameter2;
@property (nonatomic, retain) NSString * parameter3;
@property (nonatomic, retain) NSNumber * productId;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * creationDate;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Product (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(NSManagedObject *)value;
- (void)removeCommentsObject:(NSManagedObject *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
