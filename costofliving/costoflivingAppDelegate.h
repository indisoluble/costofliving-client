//
//  costoflivingAppDelegate.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ReadNewsViewController.h"
#import "ConfParametersViewController.h"



@interface costoflivingAppDelegate : NSObject <UIApplicationDelegate, ConfParametersDelegate> {
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_managedObjectModel;
    NSManagedObjectContext *_managedObjectContext;
    
    ReadNewsViewController *_readNewsViewController;
    ConfParametersViewController *_confParametersViewController;
    UITabBarController *_tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
