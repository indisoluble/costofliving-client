//
//  TagsViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 17/05/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "TagsViewController.h"
#import "TagModel.h"


@interface TagsViewController ()

@property (nonatomic, retain) NSFetchedResultsController *tagsList;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void) reloadTags;

@end


@implementation TagsViewController


#pragma mark - Synthesized methods
@synthesize tagsList = _tagsList;
@synthesize managedObjectContext = _managedObjectContext;


#pragma mark - Init object
- (id)initWithStyle:(UITableViewStyle)style
{
    return [self initWithStyle:style andManagedObjectContext:nil];    
}

- (id)initWithStyle:(UITableViewStyle)style andManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    self = [super initWithStyle:style];
    if (self) {
        // Set title
        self.title = @"Self";
        
        // Add image to Tab Bar Controller
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title
                                                         image:[UIImage imageNamed:@"165-glasses-3.png"]
                                                           tag:0] autorelease];
        
        // Set maneged object context (it can be nil)
        self.managedObjectContext = managedObjectContext;
        [self reloadTags];
    }
    return self;
}

- (void)dealloc
{
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
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSInteger numberOfSections = 0;
    if (self.tagsList) {
        numberOfSections = [[self.tagsList sections] count];
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    if (self.tagsList) {
        numberOfRows = [[[self.tagsList sections] objectAtIndex:section] numberOfObjects];
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    TagModel *oneTag = [self.tagsList objectAtIndexPath:indexPath];
    cell.textLabel.text = oneTag.descr;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


#pragma mark - Public methods
- (void) thereAreNewTags
{
    NSLog(@"There are new tags. Reload data from DataBase");
    [self reloadTags];
}


#pragma mark - Private methods
- (void) reloadTags
{
    if (self.managedObjectContext) {
        // Prepare new NSFetchedResultsController
        NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
        
        NSEntityDescription *TagModelDescription = [NSEntityDescription entityForName:@"TagModel"
                                                               inManagedObjectContext:self.managedObjectContext];
        [request setEntity:TagModelDescription];
        
        NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"descr" ascending:YES] autorelease];
        NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:sortDescriptor, nil] autorelease];
        [request setSortDescriptors:sortDescriptors];
        
        self.tagsList = [[[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                             managedObjectContext:self.managedObjectContext
                                                               sectionNameKeyPath:nil
                                                                        cacheName:@"TagModel"] autorelease];
        
        NSError *error;
        if (![self.tagsList performFetch:&error]) {
            NSLog(@"Error performing fetch to get tags <%@>", error);
            self.tagsList = nil;
        }
        
        // Force reload in tableview
        [self.tableView reloadData];
    }
}


@end
