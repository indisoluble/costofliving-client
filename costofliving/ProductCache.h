//
//  ProductCache.h
//  costofliving
//
//  Created by Enrique de la Torre on 17/04/11.
//  Copyright (c) 2011 Enrique de la Torre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>


@interface ProductCache : NSManagedObject <MKAnnotation> {
@private
}
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * idProduct;

// MKAnnotation properties
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSString *subtitle;

@end
