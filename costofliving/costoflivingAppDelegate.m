//
//  costoflivingAppDelegate.m
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "costoflivingAppDelegate.h"

@implementation costoflivingAppDelegate


#pragma mark -
#pragma mark Synthesized properties
@synthesize window = _window;
@synthesize tabBarController = _taBarController;


#pragma mark -
#pragma mark UIApplicationDelegate methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initialize tabBarController
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    
    // Tab to create and list own notes
    UINavigationController *createNotesNavController = [[[UINavigationController alloc] init] autorelease];
    createNotesNavController.title = @"Self";
    
    // Tab to check prices
    UINavigationController *checkPricesNavController = [[[UINavigationController alloc] init] autorelease];
    checkPricesNavController.title = @"Prices";
    
    // Tab to read news
    UINavigationController *readNewsNavController = [[[UINavigationController alloc] init] autorelease];
    readNewsNavController.title = @"News";
    
    // Adds tabs to tabBarController
    NSArray *viewControllers = [NSArray arrayWithObjects:createNotesNavController, checkPricesNavController, readNewsNavController, nil];
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


#pragma mark -
#pragma mark Memory management
- (void)dealloc
{
    self.tabBarController = nil;
    
    [_window release];
    [super dealloc];
}

@end
