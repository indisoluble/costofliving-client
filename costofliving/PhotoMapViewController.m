//
//  PhotoMapViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 01/04/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "PhotoMapViewController.h"


@implementation PhotoMapViewController


#pragma mark - Synthesized methods
@synthesize mapView = _mapView;
@synthesize product = _product;


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
    self.mapView = nil;
    self.product = nil;
    
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
    if (self.product) {
        [self.mapView addAnnotation:self.product];
    }
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
