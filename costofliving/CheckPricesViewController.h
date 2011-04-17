//
//  CheckPricesViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "Product.h"
#import "ActualServerProtocol.h"


@interface CheckPricesViewController : UITableViewController <ProductProtocol> {
    Product *_product;
    NSMutableArray *_productList;
    
    NSManagedObjectContext *_managedObjectContext;
    
    id<ActualServerProtocol> _delegate;
}

@property (nonatomic, retain) Product *product;
@property (nonatomic, retain) NSMutableArray *productList;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;;

@property (nonatomic, assign) id<ActualServerProtocol> delegate;

@end
