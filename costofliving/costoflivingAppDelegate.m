//
//  costoflivingAppDelegate.m
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "costoflivingAppDelegate.h"
#import "ReadNewsViewController.h"
#import "CreateNoteViewController.h"
#import "CheckPricesViewController.h"


@interface costoflivingAppDelegate (Private)

- (NSString *)applicationDocumentsDirectory;

@end


@implementation costoflivingAppDelegate


#pragma mark - Synthesized properties
@synthesize window = _window;
@synthesize tabBarController = _taBarController;
@synthesize chooseServerViewController = _chooseServerViewController;


#pragma mark - UIApplicationDelegate methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initialize tabBarController
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    
    // Tab to create and list own notes
    UINavigationController *createNotesNavController = [[[UINavigationController alloc] init] autorelease];
    CreateNoteViewController *createNoteViewController = [[[CreateNoteViewController alloc] init] autorelease];
    createNoteViewController.delegate = self;
    [createNotesNavController pushViewController:createNoteViewController animated:NO];
    
    // Tab to check prices
    UINavigationController *checkPricesNavController = [[[UINavigationController alloc] init] autorelease];
    CheckPricesViewController *checkPricesViewController = [[[CheckPricesViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    checkPricesViewController.delegate = self;
    checkPricesViewController.managedObjectContext = self.managedObjectContext;
    [checkPricesNavController pushViewController:checkPricesViewController animated:NO];
    
    // Tab to read news
    UINavigationController *readNewsNavController = [[[UINavigationController alloc] init] autorelease];
    ReadNewsViewController *readNewsViewController = [[[ReadNewsViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    [readNewsNavController pushViewController:readNewsViewController animated:NO];
    
    // Tab to choose server
    UINavigationController *chooseServerNavController = [[[UINavigationController alloc] init] autorelease];
    self.chooseServerViewController = [[[ChooseServerViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    [chooseServerNavController pushViewController:self.chooseServerViewController animated:NO];
    
    
    // Adds tabs to tabBarController
    NSArray *viewControllers = [NSArray arrayWithObjects:createNotesNavController, checkPricesNavController, readNewsNavController, chooseServerNavController,nil];
    self.tabBarController.viewControllers = viewControllers;
    
    // Show tabs
    [self.window addSubview:self.tabBarController.view];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark - Memory management
- (void)dealloc
{
    self.chooseServerViewController = nil;
    self.tabBarController = nil;
    
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    
    [_window release];
    [super dealloc];
}


#pragma mark - ActualServerProtocol methods
- (ServerData *)actualServer {
    return [self.chooseServerViewController actualServer];
}


#pragma mark - Core Data stack
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return _managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"costofliving.sqlite"]];
	
	NSError *error;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        // Handle the error.
    }    
	
    return _persistentStoreCoordinator;
}


#pragma mark - Application's documents directory
/**
 Returns the path to the application's documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}


@end
