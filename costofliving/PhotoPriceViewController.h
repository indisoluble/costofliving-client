//
//  PhotoPriceViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 31/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Product.h"


@interface PhotoPriceViewController : UIViewController {
    Product *_product;
    UIImageView *imageView;
}

@property (nonatomic, retain) Product *product;
@property (nonatomic, retain) UIImageView *imageView;

@end
