//
//  costoflivingAppDelegate.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ChooseServerViewController.h"
#import "ActualServerProtocol.h"
#import "ServerData.h"

@interface costoflivingAppDelegate : NSObject <UIApplicationDelegate, ActualServerProtocol> {
    UITabBarController *_tabBarController;
    ChooseServerViewController *_chooseServerViewController;
    
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_managedObjectModel;
    NSManagedObjectContext *_managedObjectContext;	    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) ChooseServerViewController *chooseServerViewController;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
