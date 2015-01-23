//
//  GlobalSettings.h
//  AppName
//
//  Created by Sanny on 19.01.15.
//  Copyright (c) 2015 Company. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    ProductParameterIndoor = 1,
    ProductParameterOutdoor = 2,
    ProductParameterParameter1 = 3,
    ProductParameterParameter2 = 4
};
typedef NSInteger ProductParameter;

enum {
    ProductTypeType1 = 1,
    ProductTypeType2 = 2,
    ProductTypeType3 = 3,
    ProductTypeType4 = 4,
    ProductTypeType5 = 5,
    ProductTypeType6 = 6
};
typedef NSInteger ProductType;

enum {
    SearchParameter1 = 1,
    SearchParameter2 = 2,
    SearchParameter3 = 3,
    SearchParameter4 = 4,
    SearchParameter5 = 5,
    SearchParameter6 = 6
};
typedef NSInteger SearchParameter;

@interface GlobalSettings : NSObject

@property (nonatomic, strong) NSArray *productsArray;
@property (nonatomic, strong) NSMutableArray *wishList;
@property (nonatomic, assign) BOOL isMiles;

+ (GlobalSettings *)sharedManager;
- (void)createProductsArray;

@end
