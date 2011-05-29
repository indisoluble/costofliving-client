//
//  TagsViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 17/05/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "TagsViewController.h"
#import "TagModel.h"


#pragma mark - UpdateTagsHRRestModel :: Declaration
@interface TagsHRRestModel : HRRestModel {
}

@end



#pragma mark - UpdateTagsHRRestModel :: Implementation
@implementation TagsHRRestModel

@end



#pragma mark - TagsViewController :: Implementation
@interface TagsViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSFetchedResultsController *tagsList;

@property (nonatomic, retain) ConnectionDataForPrices *connectionData;

- (void) synchronizeTags;
- (void) finishRequest;

@end


@implementation TagsViewController


#pragma mark - Synthesized methods
@synthesize tagsList = _tagsList;
@synthesize managedObjectContext = _managedObjectContext;

@synthesize connectionData = _connectionData;


#pragma - Properties
- (NSFetchedResultsController *) tagsList
{
    if (!_tagsList) {
        
        if (self.managedObjectContext) {
            
            NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
            
            NSEntityDescription *TagModelDescription = [NSEntityDescription entityForName:@"TagModel"
                                                                   inManagedObjectContext:self.managedObjectContext];
            [request setEntity:TagModelDescription];
            
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"descr" ascending:YES] autorelease];
            NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:sortDescriptor, nil] autorelease];
            [request setSortDescriptors:sortDescriptors];
            
            _tagsList = [[[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                             managedObjectContext:self.managedObjectContext
                                                               sectionNameKeyPath:nil
                                                                        cacheName:@"TagModel"] autorelease];
            
            NSError *error;
            if (![_tagsList performFetch:&error]) {
                NSLog(@"Error performing fetch to get tags <%@>", error);
                _tagsList = nil;
            }
            else
            {
                _tagsList.delegate = self;
            }
            
        }

    }
    
    return _tagsList;
}


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
    }
    return self;
}

- (void)dealloc
{
    _tagsList.delegate = nil;
    [_tagsList release];
    
    self.managedObjectContext = nil;
    
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
    
    // Display a refresh button ro force synchronize of tags with WebService
    self.navigationItem.rightBarButtonItem =
    [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                   target:self
                                                   action:@selector(synchronizeTags)] autorelease];
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


#pragma mark - NSFetchedResultsControllerDelegate methods
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView cellForRowAtIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


#pragma mark - HRResponseDelegate methods
- (void)restConnection:(NSURLConnection *)connection didReturnResource:(id)resource object:(id)object
{
    NSDictionary *dicTag = nil;
	TagModel *tagModel = nil;
	
    NSString *tagId = nil;
	NSString *tagDescr = nil;
    
    NSLog(@"Request received");
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    for(id jsonNote in resource) {
        
		if (![jsonNote respondsToSelector:@selector(objectForKey:)]) {
			NSLog(@"Object <%@> doesn't respond to 'objectForKey:'", jsonNote);
		}
		else {
            
			dicTag = [jsonNote objectForKey:@"tag"];
			if (!dicTag) {
                NSLog(@"Unknown object received <%@>", dicTag);
            }
			else {
                
                NSLog(@"Product received");
                
                /*
                 Create a new instance of the Event entity.
                 */
                tagModel = (TagModel *)[NSEntityDescription insertNewObjectForEntityForName:@"TagModel"
                                                                     inManagedObjectContext:self.managedObjectContext];
                
                tagId = [dicTag objectForKey:@"id"];
                if ((tagId != (NSString *)[NSNull null]) && tagId) {
                    tagModel.id = [NSNumber numberWithInteger:tagId.integerValue];
                }
                
                tagDescr = [dicTag objectForKey:@"descr"];
                if ((tagDescr != (NSString *)[NSNull null]) && tagDescr) {
                    tagModel.descr = tagDescr;
                }
                
            }
            
        }
        
    }
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error saving data downloaded from server <%@>", error);
    }
    
    [pool release];
    
    [self finishRequest];
}

- (void)restConnection:(NSURLConnection *)connection didFailWithError:(NSError *)error object:(id)object
{
    NSLog(@"Connection fails <<%@>>", error);
    [self finishRequest];
}

- (void)restConnection:(NSURLConnection *)connection didReceiveError:(NSError *)error response:(NSHTTPURLResponse *)response object:(id)object
{
    NSLog(@"Connection receives a non successful code <<%@>>", error);
    [self finishRequest];
}

- (void)restConnection:(NSURLConnection *)connection didReceiveParseError:(NSError *)error responseBody:(NSString *)body object:(id)object
{
    NSLog(@"Received an error parsing the response data <<%@>>", error);
    [self finishRequest];
}


#pragma mark - Public methods
- (void) useConnectionData:(ConnectionDataForPrices *)connectionData
{
    // Stop previous connections
    [self finishRequest];
    
    // Set new connection data
    self.connectionData = connectionData;
}


#pragma mark - Private methods
- (void) synchronizeTags
{
    NSLog(@"Starting tags synchronization. Sending GET request");
    [TagsHRRestModel setDelegate:self];
    [TagsHRRestModel setBaseURL:[self.connectionData url]];
	[TagsHRRestModel getPath:@"/tags.json" withOptions:nil object:nil];
}

- (void) finishRequest
{
#warning 'Set to nil' doesn't really finish the previous request
    [TagsHRRestModel setDelegate:nil];
}


@end
