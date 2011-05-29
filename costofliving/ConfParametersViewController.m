//
//  ConfParametersViewController.m
//  costofliving
//
//  Created by Enrique de la Torre on 02/05/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "ConfParametersViewController.h"
#import "ConfParameterProtocol.h"



@interface OneConfParameter : NSObject {
    NSString *_description;
    NSMutableArray *_data;
}

@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSMutableArray *data;

@end



@implementation OneConfParameter

@synthesize description = _description;
@synthesize data = _data;

#pragma mark - Memory management
- (void)dealloc
{
    self.description = nil;
    self.data = nil;
    
    [super dealloc];
}

@end



@interface ConfParametersViewController ()


#pragma mark - Properties
@property (nonatomic, retain) NSMutableArray *confParameters;


#pragma mark - Private methods
- (void)loadConfigurationPlist;

@end



@implementation ConfParametersViewController


#pragma mark - Synthesized methods
@synthesize confParameters = _confParameters;
@synthesize delegate = _delegate;


#pragma mark - Init object
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Initialize array with configuration parameters
        [self loadConfigurationPlist];
        
        // Set title before any parse operation
        self.title = @"Configuration";
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title
                                                         image:[UIImage imageNamed:@"157-wrench.png"]
                                                           tag:0] autorelease];
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
    // Return the number of sections.
    return [self.confParameters count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    OneConfParameter *confParameter = [self.confParameters objectAtIndex:section];
    
    return [confParameter.data count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    OneConfParameter *confParameter = [self.confParameters objectAtIndex:section];
    
    return confParameter.description;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    OneConfParameter *confParameter = [self.confParameters objectAtIndex:indexPath.section];
    id<ConfParameterProtocol> value = [confParameter.data objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.text = [value text];
    cell.detailTextLabel.font = [UIFont italicSystemFontOfSize:10];
    cell.detailTextLabel.text = [value detailText];
    cell.accessoryType = ([value selected] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
    
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
    OneConfParameter *confParameter = [self.confParameters objectAtIndex:indexPath.section];
    
    for (NSUInteger i = 0; i < [confParameter.data count]; i++) {
        id<ConfParameterProtocol> value = [confParameter.data objectAtIndex:i];
        [value setSelected:NO];
        
        if (i == indexPath.row) {
            [value setSelected:YES];
            
            if (self.delegate) {
                [self.delegate parameterChanged:value];
            }
        }
    }
    
    [self.tableView reloadData];
}


#pragma mark - Public methods
- (NSArray *)parameters {
    NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:[self.confParameters count]];
    
    for (OneConfParameter *confParameter in self.confParameters) {
        for (id<ConfParameterProtocol> oneValue in confParameter.data) {
            if ([oneValue selected]) {
                [values addObject:oneValue];
            }
        }
    }
    
    return [values autorelease];
}


#pragma mark - Private methods
- (void)loadConfigurationPlist
{
    NSString *pathToPlist = [[NSBundle mainBundle] pathForResource:@"costofliving-Configuration" ofType:@"plist"];
    NSArray *confParametersPlist = [NSArray arrayWithContentsOfFile:pathToPlist];
    
    self.confParameters = [NSMutableArray arrayWithCapacity:2];
    
    for (NSDictionary *confParameterPlist in confParametersPlist) {
        NSString *descriptionPlist = [confParameterPlist objectForKey:@"Description"];
        NSString *typePlist = [confParameterPlist objectForKey:@"Type"];
        NSArray *dataPlist = [confParameterPlist objectForKey:@"Data"];
        
        OneConfParameter *confParameter = [[[OneConfParameter alloc] init] autorelease];
        confParameter.description = descriptionPlist;
        confParameter.data = [[[NSMutableArray alloc] initWithCapacity:2] autorelease];
        
        for (NSDictionary *confPlist in dataPlist) {
            id value = [[(id<ConfParameterProtocol>)[NSClassFromString(typePlist) alloc] initWithDictionary:confPlist] autorelease];
            if (value) {
                [confParameter.data addObject:value];
            }
        }
        
        [self.confParameters addObject:confParameter];
    }
}


@end
