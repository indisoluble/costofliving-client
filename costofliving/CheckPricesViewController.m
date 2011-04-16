//
//  CheckPricesViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "CheckPricesViewController.h"
#import "PhotoPriceViewController.h"
#import "PhotoMapViewController.h"


@interface CheckPricesViewController (Private)

- (void) refreshProducts;

@end


@implementation CheckPricesViewController


#pragma mark - Synthesized methods
@synthesize product = _product;
@synthesize productList = _productList;
@synthesize delegate = _delegate;


#pragma mark - Init object
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Alloc product to exec 'refresh'
        self.product = [[[Product alloc] init] autorelease];
        self.product.delegate = self;
        
        // Prepare list of product
        self.productList = [NSArray array];
        
        // Set title and icon
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Prices"
                                                         image:[UIImage imageNamed:@"165-glasses-3.png"]
                                                           tag:0] autorelease];
    }
    return self;
}


#pragma mark - Memory management
- (void)dealloc
{
    self.product = nil;
    self.productList = nil;
    
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    UIBarButtonItem *mapButton =
    [[[UIBarButtonItem alloc] initWithTitle:@"Map"
                                      style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(showMap)] autorelease];
    self.navigationItem.leftBarButtonItem = mapButton;
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
																							target:self 
																							action:@selector(refreshProducts)] autorelease];
    [self refreshProducts];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.productList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    Product *oneProduct = [self.productList objectAtIndex:indexPath.row];
	if (oneProduct) {
        //cell.imageView.image = oneProduct.image;
        
		cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
		cell.textLabel.text = oneProduct.name;
        
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%i €", oneProduct.price];
	}
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Product *oneProduct = [self.productList objectAtIndex:indexPath.row];
        if (oneProduct) {
            // Delete the row from the data source
            [oneProduct deleteRemoteFromServer:[self.delegate actualServer]];
            [self.productList removeObjectAtIndex:indexPath.row];
            
            // Delete the row from the view
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    PhotoPriceViewController *detailViewController = [[PhotoPriceViewController alloc] initWithNibName:@"PhotoPriceViewController" bundle:nil];
    detailViewController.product = [self.productList objectAtIndex:indexPath.row];
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


#pragma mark - ProductProtocol methods
- (void)useProductsList:(NSMutableArray *)list
{
    NSLog(@"Finished refreshing");
    self.productList = list;
    
    self.title = @"Prices";
    self.navigationItem.leftBarButtonItem.enabled = YES;
	self.tableView.userInteractionEnabled = YES;
	self.tableView.alpha = 1;
	[self.tableView reloadData];
}


#pragma mark - Private methods
- (void) refreshProducts
{
    self.title = @"Refreshing...";
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.tableView.userInteractionEnabled = NO;
	self.tableView.alpha = 0.3;
    
    [self.product refreshFromSerer:[self.delegate actualServer]];
}

- (void)showMap {
    // Navigation logic may go here. Create and push another view controller.
    PhotoMapViewController *detailViewController = [[PhotoMapViewController alloc] initWithNibName:@"PhotoMapViewController" bundle:nil];
    detailViewController.products = self.productList;
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

@end
