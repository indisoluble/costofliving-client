//
//  TagsViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 17/05/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ConnectionDataForPrices.h"
#import "HTTPRiot.h"


@interface TagsViewController : UITableViewController <NSFetchedResultsControllerDelegate, HRResponseDelegate> {
    NSManagedObjectContext *_managedObjectContext;
    NSFetchedResultsController *_tagsList;
    
    ConnectionDataForPrices *_connectionData;
}

- (id)initWithStyle:(UITableViewStyle)style andManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (void) useConnectionData:(ConnectionDataForPrices *)connectionData;

@end
