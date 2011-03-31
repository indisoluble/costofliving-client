//
//  CreateNoteViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "CreateNoteViewController.h"
#import "Product.h"


@interface CreateNoteViewController (Private)

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
								   usingDelegate: (id <UIImagePickerControllerDelegate,
												   UINavigationControllerDelegate>) delegate;

- (void) returnToProduct: (UIImage *)image;

@end


@implementation CreateNoteViewController


#pragma mark - Synthesized methods
@synthesize name = _name;
@synthesize price = _price;
@synthesize imageView = _imageView;

@synthesize delegate = _delegate;


#pragma mark - Init object
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Self";
    }
    return self;
}


#pragma mark - Memory management
- (void)dealloc
{
    self.name = nil;
    self.price = nil;
    self.imageView = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {	
	[textField resignFirstResponder];
	return YES;
}


#pragma mark - UIImagePickerControllerDelegate methods
// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
	
    [[picker parentViewController] dismissModalViewControllerAnimated: YES];
    [picker release];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
	
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
	
	// Handle a movie capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
		NSLog(@"Handle movie not allowed. Do nothing!!!");
    }
	
	// Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
		
        editedImage = (UIImage *) [info objectForKey:
								   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
									 UIImagePickerControllerOriginalImage];
		
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
		
    }
	
	// Dismiss camera control
    [[picker parentViewController] dismissModalViewControllerAnimated: YES];
    [picker release];
	
    // Return image
	[self returnToProduct: imageToSave];
}


#pragma mark - Actions
- (IBAction) showCamera {
	if (![self startCameraControllerFromViewController:self usingDelegate:self]) {
		NSLog(@"Some error detected. Continue note");
		[self returnToProduct:nil];
	}
}


- (IBAction) saveProduct
{
    Product *oneProduct = [[[Product alloc] init] autorelease];
	oneProduct.name = self.name.text;
	oneProduct.price = self.price.text.integerValue;
    oneProduct.image = self.imageView.image;
	[oneProduct saveRemoteToServer:[self.delegate actualSever]];
    
    self.name.text = nil;
    self.price.text = nil;
    self.imageView.image = nil;
    
    if ([self.name isFirstResponder]) {
        [self.name resignFirstResponder];
    }
    else if ([self.price isFirstResponder]) {
        [self.price resignFirstResponder];
    }
}


#pragma mark - Private methods
- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
								   usingDelegate: (id <UIImagePickerControllerDelegate,
												   UINavigationControllerDelegate>) delegate {
	
    if (([UIImagePickerController isSourceTypeAvailable:
		  UIImagePickerControllerSourceTypeCamera] == NO)
		|| (delegate == nil)
		|| (controller == nil))
	{
		NSLog(@"Source not available");
        return NO;
	}
	
	
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
	
    // Only image capture allowed
    cameraUI.mediaTypes = [[[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil] autorelease];
	
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
	
    cameraUI.delegate = delegate;
	
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}

- (void) returnToProduct: (UIImage *)image {
    if (image) {
        self.imageView.image = image;
    }
}


@end
