//
//  ChooseServerViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 31/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "ChooseServerViewController.h"


@interface ChooseServerViewController (Private)
- (void) changeActualServer;
@end


@implementation ChooseServerViewController


#pragma mark - Synthesized methods


#pragma mark - Init object
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        NSString *pathToPlist = [[NSBundle mainBundle] pathForResource:@"costofliving-Servers" ofType:@"plist"];
        NSArray *serversPlist = [NSArray arrayWithContentsOfFile:pathToPlist];
        
        _servers = [[NSMutableArray alloc] initWithCapacity:[serversPlist count]];
        _selected = 0;
        
        NSDictionary *oneServerPlist = nil;
        ServerData *oneServer = nil;
        for (int i = 0; i < [serversPlist count]; i++) {
            oneServerPlist = [serversPlist objectAtIndex:i];
            
            oneServer = [[[ServerData alloc] initWithName:[oneServerPlist objectForKey:@"Name"]
                                                  Address:[oneServerPlist objectForKey:@"Address"]
                                              AllowPhotos:[[oneServerPlist objectForKey:@"AllowPhotos"] boolValue]] autorelease];
            
            [_servers addObject:oneServer];
            
            if ([[oneServerPlist objectForKey:@"Selected"] boolValue]) {
                _selected = i;
            }
        }
        
        _selectedTemp = _selected;
        self.title = [[_servers objectAtIndex:_selected] name];
    }
    return self;
}


#pragma mark - Memory management
- (void)dealloc
{
    [_servers release];
    
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
 
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
																							target:self 
																							action:@selector(changeActualServer)] autorelease];
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
    return [_servers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    ServerData *oneServer = [_servers objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.text = oneServer.name;
    cell.detailTextLabel.font = [UIFont italicSystemFontOfSize:10];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Allow photos: %@ Addr: %@", (oneServer.allowPhotos ? @"YES" : @"NO"), oneServer.address];
    
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
    _selectedTemp = indexPath.row;
}


#pragma mark - Public methods
- (ServerData *)actualServer {
    return [_servers objectAtIndex:_selected];
}


#pragma mark - Private methods
- (void) changeActualServer {
    _selected = _selectedTemp;
    self.title = [[_servers objectAtIndex:_selected] name];
}


@end
