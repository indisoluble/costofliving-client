//
//  TagsViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 17/05/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@protocol TagsViewControllerProtocol <NSObject>

- (NSManagedObjectContext *) managedObjectModelForTheApplication;

@end


@interface TagsViewController : UITableViewController {
    NSFetchedResultsController *_tagsList;
    NSManagedObjectContext *_managedObjectContext;
}

- (id)initWithStyle:(UITableViewStyle)style andManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (void)thereAreNewTags;

@end
