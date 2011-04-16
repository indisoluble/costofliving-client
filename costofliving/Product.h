//
//  Product.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


#import "HTTPRiot.h"
#import "ServerData.h"


@protocol ProductProtocol

- (void)useProductsList:(NSMutableArray *)list;

@end


@interface Product : NSObject <HRResponseDelegate, MKAnnotation> {
    NSInteger _idProduct;
    NSString *_name;
    NSUInteger _price; 
    UIImage *_image;
    double _latitude;
    double _longitude;
    NSString *_address;
    
    id<ProductProtocol> _delegate;
}

@property (nonatomic) NSInteger idProduct;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSUInteger price;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, retain) NSString *address;

@property (nonatomic, assign) id<ProductProtocol> delegate;

// MKAnnotation properties
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;
@property (readonly, nonatomic) NSString *subtitle;

- (void)saveRemoteToServer:(ServerData *)server;
- (void)deleteRemoteFromServer:(ServerData *)server;
- (void)refreshFromSerer:(ServerData *)server;

@end
