//
//  ReadNewsViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "ReadNewsViewController.h"
#import "DetailNewsViewController.h"
#import "NSString+HTML.h"


@interface ReadNewsViewController (Private)

- (void) refreshItems;

@end


@implementation ReadNewsViewController

#pragma mark - Synthesized methods
@synthesize feedParser = _feedParser;
@synthesize parsedItems = _parsedItems;
@synthesize itemsToDisplay = _itemsToDisplay;

@synthesize dateFormatter = _dateFormatter;


#pragma mark - Init object
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Setup parser
        NSURL *feedURL = [NSURL URLWithString:@"feed://web.me.com/indisoluble/Test/Blog/rss.xml"];
        
        self.feedParser = [[[MWFeedParser alloc] initWithFeedURL:feedURL] autorelease];
        self.feedParser.delegate = self;
        self.feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
        self.feedParser.connectionType = ConnectionTypeAsynchronously;
        
        // Setup list of items
        self.parsedItems = [NSMutableArray array];
        self.itemsToDisplay = [NSArray array];
        
        // Setup date formatter
        self.dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        // Set title
        self.title = @"News";
    }
    return self;
}


#pragma mark - Memory management
- (void)dealloc
{
    self.feedParser = nil;
    self.parsedItems = nil;
    self.itemsToDisplay = nil;
    
    self.dateFormatter = nil;
    
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
 
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
																							target:self 
																							action:@selector(refreshItems)] autorelease];
    [self refreshItems];
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
    // Return the number of rows in the section.
    return [self.itemsToDisplay count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    MWFeedItem *item = [self.itemsToDisplay objectAtIndex:indexPath.row];
	if (item) {
		// Process
		NSString *itemTitle = (item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]");
        
        NSMutableString *subtitle = [NSMutableString string];
		if (item.date) {
            [subtitle appendFormat:@"%@: ", [self.dateFormatter stringFromDate:item.date]];
        }
        NSString *itemSummary = (item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]");
		[subtitle appendString:itemSummary];
		
		// Set
		cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
		cell.textLabel.text = itemTitle;
		cell.detailTextLabel.text = subtitle;
	}
    
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
    DetailNewsViewController *detailNewsViewController = [[[DetailNewsViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    detailNewsViewController.item = (MWFeedItem *)[self.itemsToDisplay objectAtIndex:indexPath.row];
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailNewsViewController animated:YES];
}


#pragma mark - MWFeedParserDelegate methods
- (void)feedParserDidStart:(MWFeedParser *)parser
{
    NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info
{
    NSLog(@"Parsed Feed Info: “%@”", info.title);
	self.title = info.title;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
    NSLog(@"Parsed Feed Item: “%@”", item.title);
	if (item) {
        [self.parsedItems addObject:item];
    }
}

- (void)feedParserDidFinish:(MWFeedParser *)parser
{
    NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
	self.itemsToDisplay = [self.parsedItems sortedArrayUsingDescriptors:
						   [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"date" 
																				 ascending:NO] autorelease]]];
    
    self.title = @"News";
	self.tableView.userInteractionEnabled = YES;
	self.tableView.alpha = 1;
	[self.tableView reloadData];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
	NSLog(@"Finished Parsing With Error: %@", error);
	self.title = @"Failed";
	self.itemsToDisplay = [NSArray array];
	[self.parsedItems removeAllObjects];
    
    self.title = @"News";
	self.tableView.userInteractionEnabled = YES;
	self.tableView.alpha = 1;
	[self.tableView reloadData];
}


#pragma mark - Private methods
- (void) refreshItems
{
    self.title = @"Refreshing...";
    self.tableView.userInteractionEnabled = NO;
	self.tableView.alpha = 0.3;
    
    [self.feedParser stopParsing];
	[self.parsedItems removeAllObjects];
	[self.feedParser parse];
}

@end
