//
//  DetailNewsViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedItem.h"


@interface DetailNewsViewController : UITableViewController {
    MWFeedItem *_item;
    NSString *_dateString;
    NSString *_summaryString;
}

@property (nonatomic, retain) MWFeedItem *item;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *summary;

@end
