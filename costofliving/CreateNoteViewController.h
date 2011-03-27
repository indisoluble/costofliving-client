//
//  CreateNoteViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreateNoteViewController : UIViewController <UITextFieldDelegate> {
    UITextField *_name;
    UITextField *_price;
}

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *price;

- (IBAction) saveProduct;

@end
