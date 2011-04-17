//
//  Product.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


#import "HTTPRiot.h"
#import "ServerData.h"


@protocol ProductProtocol

- (NSManagedObjectContext *) managedObjectContext;;
- (void)useProductsList;

@end


@interface Product : NSObject <HRResponseDelegate> {
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

- (void)saveRemoteToServer:(ServerData *)server;
- (void)deleteRemoteFromServer:(ServerData *)server;
- (void)refreshFromSerer:(ServerData *)server;

@end
