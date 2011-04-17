//
//  PhotoPriceViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 31/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "PhotoPriceViewController.h"
#import "PhotoMapViewController.h"


@interface PhotoPriceViewController (Private)

- (void)showMap;

@end


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
        self.title = self.product.name;
        
        if (self.product.image) {
            self.imageView = [[[UIImageView alloc] initWithImage:[UIImage imageWithData:self.product.image]] autorelease];
        }
        else {
            self.imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog.jpg"]] autorelease];
        }
        
		[self.view addSubview:self.imageView];
		[(UIScrollView *)self.view setContentSize:[self.imageView.image size]];
		[(UIScrollView *)self.view setMaximumZoomScale:2.0];
        [(UIScrollView *)self.view setMinimumZoomScale:0.1];
        
        if (self.product.image) {
            UIBarButtonItem *mapButton =
            [[[UIBarButtonItem alloc] initWithTitle:@"Map"
                                              style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(showMap)] autorelease];
            self.navigationItem.rightBarButtonItem = mapButton;
        }
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


#pragma mark - Private methods
- (void)showMap {
    // Navigation logic may go here. Create and push another view controller.
    PhotoMapViewController *detailViewController = [[PhotoMapViewController alloc] initWithNibName:@"PhotoMapViewController" bundle:nil];
    detailViewController.products = [NSArray arrayWithObject:self.product];
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

@end
