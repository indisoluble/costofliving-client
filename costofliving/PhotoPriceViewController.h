//
//  PhotoPriceViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 31/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProductCache.h"


@interface PhotoPriceViewController : UIViewController {
    ProductCache *_product;
    UIImageView *imageView;
}

@property (nonatomic, retain) ProductCache *product;
@property (nonatomic, retain) UIImageView *imageView;

@end
