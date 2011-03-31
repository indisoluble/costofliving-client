//
//  CheckPricesViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Product.h"
#import "ActualServerProtocol.h"


@interface CheckPricesViewController : UITableViewController <ProductProtocol> {
    Product *_product;
    NSArray *_productList;
    
    id<ActualServerProtocol> _delegate;
}

@property (nonatomic, retain) Product *product;
@property (nonatomic, retain) NSArray *productList;

@property (nonatomic, assign) id<ActualServerProtocol> delegate;

@end
