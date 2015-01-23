//
//  GlobalSettings.m
//  AppName
//
//  Created by Sanny on 19.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import "GlobalSettings.h"
#import "CustomProduct.h"

static GlobalSettings *sharedInstance = nil;

@implementation GlobalSettings

+ (GlobalSettings *)sharedManager {
    
    if (sharedInstance == nil) {
        sharedInstance = [[GlobalSettings alloc] init];
    }
    
    return sharedInstance;
}

- (void)createProductsArray {
        
    CustomProduct *product1 = [[CustomProduct alloc] init];
    product1.productId = [NSNumber numberWithInt:1];
    product1.productName = @"First product";
    product1.creatorName = @"User Name 1";
    product1.type = [NSNumber numberWithInt:ProductTypeType3];
    product1.rating = [NSNumber numberWithFloat:4.3];
    product1.parameter1 = @"Value1";
    product1.parameter2 = @"Value2";
    product1.parameter3 = @"Value3";
    product1.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product1.distance = [NSNumber numberWithFloat:1.5];
    product1.searchParameters = @[[NSNumber numberWithInt:SearchParameter2], [NSNumber numberWithInt:SearchParameter5]];
    product1.creationDate = @"12.05.2014";
    
    CustomProduct *product2 = [[CustomProduct alloc] init];
    product2.productId = [NSNumber numberWithInt:2];
    product2.productName = @"Second product";
    product2.creatorName = @"User Name 5";
    product2.type = [NSNumber numberWithInt:ProductTypeType2];
    product2.rating = [NSNumber numberWithFloat:3.7];
    product2.parameter1 = @"Value4";
    product2.parameter2 = @"Value1";
    product2.parameter3 = @"Value6";
    product2.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product2.distance = [NSNumber numberWithFloat:3.2];
    product2.searchParameters = @[[NSNumber numberWithInt:SearchParameter2], [NSNumber numberWithInt:SearchParameter6]];
    product2.creationDate = @"16.01.2015";
    
    CustomProduct *product3 = [[CustomProduct alloc] init];
    product3.productId = [NSNumber numberWithInt:3];
    product3.productName = @"Third product";
    product3.creatorName = @"User Name 1";
    product3.type = [NSNumber numberWithInt:ProductTypeType1];
    product3.rating = [NSNumber numberWithFloat:4.2];
    product3.parameter1 = @"Value3";
    product3.parameter2 = @"Value4";
    product3.parameter3 = @"Value2";
    product3.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product3.distance = [NSNumber numberWithFloat:2.7];
    product3.searchParameters = @[[NSNumber numberWithInt:SearchParameter1], [NSNumber numberWithInt:SearchParameter3]];
    product3.creationDate = @"12.06.2013";
    
    CustomProduct *product4 = [[CustomProduct alloc] init];
    product4.productId = [NSNumber numberWithInt:4];
    product4.productName = @"Product 4";
    product4.creatorName = @"User Name 8";
    product4.type = [NSNumber numberWithInt:ProductTypeType6];
    product4.rating = [NSNumber numberWithFloat:4.6];
    product4.parameter1 = @"Value1";
    product4.parameter2 = @"Value2";
    product4.parameter3 = @"Value3";
    product4.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product4.distance = [NSNumber numberWithFloat:1.7];
    product4.searchParameters = @[[NSNumber numberWithInt:SearchParameter4], [NSNumber numberWithInt:SearchParameter6]];
    product4.creationDate = @"11.05.2014";
    
    CustomProduct *product5 = [[CustomProduct alloc] init];
    product5.productId = [NSNumber numberWithInt:5];
    product5.productName = @"product 5";
    product5.creatorName = @"User Name 3";
    product5.type = [NSNumber numberWithInt:ProductTypeType5];
    product5.rating = [NSNumber numberWithFloat:4.0];
    product5.parameter1 = @"Value1";
    product5.parameter2 = @"Value2";
    product5.parameter3 = @"Value3";
    product5.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product5.distance = [NSNumber numberWithFloat:4.2];
    product5.searchParameters = @[[NSNumber numberWithInt:SearchParameter2], [NSNumber numberWithInt:SearchParameter5]];
    product5.creationDate = @"14.05.2014";
    
    CustomProduct *product6 = [[CustomProduct alloc] init];
    product6.productId = [NSNumber numberWithInt:6];
    product6.productName = @"Product 6";
    product6.creatorName = @"User Name 2";
    product6.type = [NSNumber numberWithInt:ProductTypeType4];
    product6.rating = [NSNumber numberWithFloat:4.1];
    product6.parameter1 = @"Value1";
    product6.parameter2 = @"Value2";
    product6.parameter3 = @"Value3";
    product6.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product6.distance = [NSNumber numberWithFloat:1.9];
    product6.searchParameters = @[[NSNumber numberWithInt:SearchParameter1], [NSNumber numberWithInt:SearchParameter4]];
    product6.creationDate = @"12.07.2014";
    
    CustomProduct *product7 = [[CustomProduct alloc] init];
    product7.productId = [NSNumber numberWithInt:7];
    product7.productName = @"Product 7";
    product7.creatorName = @"User Name 3";
    product7.type = [NSNumber numberWithInt:ProductTypeType3];
    product7.rating = [NSNumber numberWithFloat:4.5];
    product7.parameter1 = @"Value1";
    product7.parameter2 = @"Value2";
    product7.parameter3 = @"Value3";
    product7.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product7.distance = [NSNumber numberWithFloat:1.0];
    product7.searchParameters = @[[NSNumber numberWithInt:SearchParameter2], [NSNumber numberWithInt:SearchParameter3]];
    product7.creationDate = @"25.08.2014";
    
    CustomProduct *product8 = [[CustomProduct alloc] init];
    product8.productId = [NSNumber numberWithInt:8];
    product8.productName = @"Product 8";
    product8.creatorName = @"User Name 5";
    product8.type = [NSNumber numberWithInt:ProductTypeType2];
    product8.rating = [NSNumber numberWithFloat:4.1];
    product8.parameter1 = @"Value1";
    product8.parameter2 = @"Value5";
    product8.parameter3 = @"Value3";
    product8.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product8.distance = [NSNumber numberWithFloat:1.9];
    product8.searchParameters = @[[NSNumber numberWithInt:SearchParameter3], [NSNumber numberWithInt:SearchParameter4]];
    product8.creationDate = @"02.01.2015";
    
    CustomProduct *product9 = [[CustomProduct alloc] init];
    product9.productId = [NSNumber numberWithInt:9];
    product9.productName = @"Product 9";
    product9.creatorName = @"User Name 4";
    product9.type = [NSNumber numberWithInt:ProductTypeType1];
    product9.rating = [NSNumber numberWithFloat:4.1];
    product9.parameter1 = @"Value1";
    product9.parameter2 = @"Value2";
    product9.parameter3 = @"Value3";
    product9.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product9.distance = [NSNumber numberWithFloat:2.7];
    product9.searchParameters = @[[NSNumber numberWithInt:SearchParameter3], [NSNumber numberWithInt:SearchParameter5]];
    product9.creationDate = @"14.05.2014";
    
    CustomProduct *product10 = [[CustomProduct alloc] init];
    product10.productId = [NSNumber numberWithInt:10];
    product10.productName = @"Product 10";
    product10.creatorName = @"User Name 3";
    product10.type = [NSNumber numberWithInt:ProductTypeType6];
    product10.rating = [NSNumber numberWithFloat:3.5];
    product10.parameter1 = @"Value1";
    product10.parameter2 = @"Value2";
    product10.parameter3 = @"Value3";
    product10.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product10.distance = [NSNumber numberWithFloat:1.8];
    product10.searchParameters = @[[NSNumber numberWithInt:SearchParameter4], [NSNumber numberWithInt:SearchParameter2]];
    product10.creationDate = @"12.08.2014";
    
    CustomProduct *product11 = [[CustomProduct alloc] init];
    product11.productId = [NSNumber numberWithInt:11];
    product11.productName = @"Product 11";
    product11.creatorName = @"User Name 1";
    product11.type = [NSNumber numberWithInt:ProductTypeType5];
    product11.rating = [NSNumber numberWithFloat:1.7];
    product11.parameter1 = @"Value1";
    product11.parameter2 = @"Value2";
    product11.parameter3 = @"Value3";
    product11.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product11.distance = [NSNumber numberWithFloat:5.9];
    product11.searchParameters = @[[NSNumber numberWithInt:SearchParameter4], [NSNumber numberWithInt:SearchParameter6]];
    product11.creationDate = @"17.05.2014";
    
    CustomProduct *product12 = [[CustomProduct alloc] init];
    product12.productId = [NSNumber numberWithInt:12];
    product12.productName = @"Product 12";
    product12.creatorName = @"User Name 4";
    product12.type = [NSNumber numberWithInt:ProductTypeType4];
    product12.rating = [NSNumber numberWithFloat:4.0];
    product12.parameter1 = @"Value1";
    product12.parameter2 = @"Value6";
    product12.parameter3 = @"Value3";
    product12.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product12.distance = [NSNumber numberWithFloat:3.6];
    product12.searchParameters = @[[NSNumber numberWithInt:SearchParameter1], [NSNumber numberWithInt:SearchParameter4]];
    product12.creationDate = @"12.03.2013";
    
    CustomProduct *product13 = [[CustomProduct alloc] init];
    product13.productId = [NSNumber numberWithInt:13];
    product13.productName = @"Product 13";
    product13.creatorName = @"User Name 4";
    product13.type = [NSNumber numberWithInt:ProductTypeType3];
    product13.rating = [NSNumber numberWithFloat:2.5];
    product13.parameter1 = @"Value1";
    product13.parameter2 = @"Value2";
    product13.parameter3 = @"Value4";
    product13.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product13.distance = [NSNumber numberWithFloat:2.6];
    product13.searchParameters = @[[NSNumber numberWithInt:SearchParameter3], [NSNumber numberWithInt:SearchParameter5]];
    product13.creationDate = @"10.05.2014";
    
    CustomProduct *product14 = [[CustomProduct alloc] init];
    product14.productId = [NSNumber numberWithInt:14];
    product14.productName = @"Product 14";
    product14.creatorName = @"User Name 1";
    product14.type = [NSNumber numberWithInt:ProductTypeType2];
    product14.rating = [NSNumber numberWithFloat:4.2];
    product14.parameter1 = @"Value1";
    product14.parameter2 = @"Value2";
    product14.parameter3 = @"Value3";
    product14.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product14.distance = [NSNumber numberWithFloat:1.9];
    product14.searchParameters = @[[NSNumber numberWithInt:SearchParameter3], [NSNumber numberWithInt:SearchParameter6]];
    product14.creationDate = @"10.11.2014";
    
    CustomProduct *product15 = [[CustomProduct alloc] init];
    product15.productId = [NSNumber numberWithInt:15];
    product15.productName = @"Product 15";
    product15.creatorName = @"User Name 3";
    product15.type = [NSNumber numberWithInt:ProductTypeType1];
    product15.rating = [NSNumber numberWithFloat:3.4];
    product15.parameter1 = @"Value1";
    product15.parameter2 = @"Value2";
    product15.parameter3 = @"Value3";
    product15.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product15.distance = [NSNumber numberWithFloat:2.8];
    product15.searchParameters = @[[NSNumber numberWithInt:SearchParameter1], [NSNumber numberWithInt:SearchParameter5]];
    product15.creationDate = @"07.05.2014";
    
    CustomProduct *product16 = [[CustomProduct alloc] init];
    product16.productId = [NSNumber numberWithInt:16];
    product16.productName = @"Product 16";
    product16.creatorName = @"User Name 2";
    product16.type = [NSNumber numberWithInt:ProductTypeType6];
    product16.rating = [NSNumber numberWithFloat:4.1];
    product16.parameter1 = @"Value1";
    product16.parameter2 = @"Value2";
    product16.parameter3 = @"Value3";
    product16.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product16.distance = [NSNumber numberWithFloat:1.8];
    product16.searchParameters = @[[NSNumber numberWithInt:SearchParameter3], [NSNumber numberWithInt:SearchParameter5]];
    product16.creationDate = @"14.09.2014";
    
    CustomProduct *product17 = [[CustomProduct alloc] init];
    product17.productId = [NSNumber numberWithInt:17];
    product17.productName = @"Product 17";
    product17.creatorName = @"User Name 8";
    product17.type = [NSNumber numberWithInt:ProductTypeType3];
    product17.rating = [NSNumber numberWithFloat:4.2];
    product17.parameter1 = @"Value6";
    product17.parameter2 = @"Value2";
    product17.parameter3 = @"Value3";
    product17.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product17.distance = [NSNumber numberWithFloat:2.3];
    product17.searchParameters = @[[NSNumber numberWithInt:SearchParameter2], [NSNumber numberWithInt:SearchParameter5]];
    product17.creationDate = @"12.12.2014";
    
    CustomProduct *product18 = [[CustomProduct alloc] init];
    product18.productId = [NSNumber numberWithInt:18];
    product18.productName = @"Product 18";
    product18.creatorName = @"User Name 4";
    product18.type = [NSNumber numberWithInt:ProductTypeType5];
    product18.rating = [NSNumber numberWithFloat:4.0];
    product18.parameter1 = @"Value5";
    product18.parameter2 = @"Value2";
    product18.parameter3 = @"Value3";
    product18.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product18.distance = [NSNumber numberWithFloat:1.7];
    product18.searchParameters = @[[NSNumber numberWithInt:SearchParameter4], [NSNumber numberWithInt:SearchParameter5]];
    product18.creationDate = @"12.01.2015";
    
    CustomProduct *product19 = [[CustomProduct alloc] init];
    product19.productId = [NSNumber numberWithInt:19];
    product19.productName = @"Product 19";
    product19.creatorName = @"User Name 5";
    product19.type = [NSNumber numberWithInt:ProductTypeType4];
    product19.rating = [NSNumber numberWithFloat:3.3];
    product19.parameter1 = @"Value4";
    product19.parameter2 = @"Value2";
    product19.parameter3 = @"Value3";
    product19.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product19.distance = [NSNumber numberWithFloat:2.7];
    product19.searchParameters = @[[NSNumber numberWithInt:SearchParameter3], [NSNumber numberWithInt:SearchParameter4]];
    product19.creationDate = @"12.06.2014";
    
    CustomProduct *product20 = [[CustomProduct alloc] init];
    product20.productId = [NSNumber numberWithInt:20];
    product20.productName = @"Product 20";
    product20.creatorName = @"User Name 1";
    product20.type = [NSNumber numberWithInt:ProductTypeType3];
    product20.rating = [NSNumber numberWithFloat:4.2];
    product20.parameter1 = @"Value1";
    product20.parameter2 = @"Value2";
    product20.parameter3 = @"Value3";
    product20.imageURL = @"https://pbs.twimg.com/profile_images/604644048/sign051.gif";
    product20.distance = [NSNumber numberWithFloat:1.2];
    product20.searchParameters = @[[NSNumber numberWithInt:SearchParameter2], [NSNumber numberWithInt:SearchParameter5]];
    product20.creationDate = @"12.07.2014";
    
    self.productsArray = [NSArray arrayWithObjects: product1, product2, product3, product4, product5, product6, product7, product8, product9, product10, product11, product12, product13, product14, product15, product16, product17, product18, product19, product20, nil];
    
}

@end
