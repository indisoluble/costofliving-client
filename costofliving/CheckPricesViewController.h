//
//  CheckPricesViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"


@interface CheckPricesViewController : UITableViewController <ProductProtocol> {
    Product *_product;
    NSArray *_productList;
}

@property (nonatomic, retain) Product *product;
@property (nonatomic, retain) NSArray *productList;

@end
