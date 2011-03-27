//
//  CreateNoteViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "CreateNoteViewController.h"
#import "Product.h"


@implementation CreateNoteViewController


#pragma mark - Synthesized methods
@synthesize name = _name;
@synthesize price = _price;


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


#pragma mark - Actions
- (IBAction) saveProduct
{
    Product *oneProduct = [[[Product alloc] init] autorelease];
	oneProduct.name = self.name.text;
	oneProduct.price = self.price.text.integerValue;
	[oneProduct saveRemote];
}

@end
