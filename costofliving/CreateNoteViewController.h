//
//  CreateNoteViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ActualServerProtocol.h"


@interface CreateNoteViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    UITextField *_name;
    UITextField *_price;
    UIImageView *_imageView;
    
    id<ActualServerProtocol> _delegate;
}

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *price;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@property (nonatomic, assign) id<ActualServerProtocol> delegate;

- (IBAction) showCamera;
- (IBAction) saveProduct;

@end
