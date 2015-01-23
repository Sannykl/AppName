//
//  CustomProduct.h
//  AppName
//
//  Created by Sanny on 19.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomProduct : NSObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSString * parameter1;
@property (nonatomic, retain) NSString * parameter2;
@property (nonatomic, retain) NSString * parameter3;
@property (nonatomic, retain) NSString * creatorName;
@property (nonatomic, retain) NSArray * searchParameters;
@property (nonatomic, retain) NSNumber * productId;
@property (nonatomic, retain) NSString * creationDate;

@end
