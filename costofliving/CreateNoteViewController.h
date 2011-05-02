//
//  CreateNoteViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "ActualServerProtocol.h"
#import "Product.h"


@interface CreateNoteViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate> {
    UITextField *_name;
    UITextField *_price;
    UIImageView *_imageView;
    
    CLLocationManager *_locationManager;
    CLLocation *_actualLocation;
    
    Product *_product;

    id<ActualServerProtocol> _delegate;
}

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *price;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *actualLocation;

@property (nonatomic, retain) Product *product;

@property (nonatomic, assign) id<ActualServerProtocol> delegate;

- (IBAction) showCamera;
- (IBAction) saveProduct;

@end
