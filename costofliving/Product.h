//
//  Product.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRiot.h"


@protocol ProductProtocol

- (void)useProductsList:(NSArray *)list;

@end


@interface Product : NSObject <HRResponseDelegate> {
    NSString *_name;
    NSUInteger _price;
    
    id<ProductProtocol> _delegate;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSUInteger price;

@property (nonatomic, assign) id<ProductProtocol> delegate;

- (void) saveRemote;
- (void)refresh;

@end
