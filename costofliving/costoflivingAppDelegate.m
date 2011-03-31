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
    
    [_window release];
    [super dealloc];
}


#pragma mark - ActualServerProtocol methods
- (ServerData *)actualSever {
    return [self.chooseServerViewController actualServer];
}

@end
