//
//  ProductCache.m
//  costofliving
//
//  Created by Enrique de la Torre on 17/04/11.
//  Copyright (c) 2011 Enrique de la Torre. All rights reserved.
//

#import "ProductCache.h"


@implementation ProductCache
@dynamic price;
@dynamic longitude;
@dynamic latitude;
@dynamic image;
@dynamic name;
@dynamic address;
@dynamic idProduct;

#pragma mark - MKAnnotation properties
- (CLLocationCoordinate2D) coordinate {
	CLLocationCoordinate2D coord;
	coord.latitude = self.latitude.doubleValue;
	coord.longitude = self.longitude.doubleValue;
	
	return coord;
}

- (NSString *) title {
	return self.name;
}

- (NSString *)subtitle {
    return self.address;
}

@end
