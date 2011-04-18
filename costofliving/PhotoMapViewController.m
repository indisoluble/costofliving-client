//
//  PhotoMapViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 01/04/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "PhotoMapViewController.h"
#import "ProductCache.h"


@implementation PhotoMapViewController


#pragma mark - Synthesized methods
@synthesize mapView = _mapView;
@synthesize products = _products;


#pragma mark - Init object
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (!self.title) {
            self.title = @"Map";
        }
    }
    return self;
}


#pragma mark - Memory management
- (void)dealloc
{
    self.mapView = nil;
    self.products = nil;
    
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
    if (self.products) {
        
        if ([self.products isMemberOfClass: [ProductCache class]]) {
            [self.mapView addAnnotation:self.products];
        }
        else {
            id <NSFetchedResultsSectionInfo> sectionInfo;
            for (NSInteger i = 0; i < [[self.products sections] count]; i++) {
                sectionInfo = [[self.products sections] objectAtIndex:i];
                for (ProductCache *oneProduct in sectionInfo.objects) {
                    if (oneProduct.image) {
                        // If it has an image, the coordinates are correct
                        [self.mapView addAnnotation:oneProduct];
                    }
                }
            }
        } 
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
