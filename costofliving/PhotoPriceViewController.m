//
//  PhotoPriceViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 31/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "PhotoPriceViewController.h"


@implementation PhotoPriceViewController


#pragma mark - Synthesized methods
@synthesize product = _product;
@synthesize imageView = _imageView;


#pragma mark - Init object
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - Memory management
- (void)dealloc
{
    self.product = nil;
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
	if (self.product != nil) {
		self.imageView = [[[UIImageView alloc] initWithImage:self.product.image] autorelease];
        
		[self.view addSubview:self.imageView];
		[(UIScrollView *)self.view setContentSize:[self.imageView.image size]];
		[(UIScrollView *)self.view setMaximumZoomScale:2.0];
        [(UIScrollView *)self.view setMinimumZoomScale:0.1];
	}

}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *) scrollView {
	return self.imageView;
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

@end
