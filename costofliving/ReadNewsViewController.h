//
//  ReadNewsViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@interface ReadNewsViewController : UITableViewController <MWFeedParserDelegate> {
    MWFeedParser *_feedParser;
    NSMutableArray *_parsedItems;
    NSArray *_itemsToDisplay;
    
    NSDateFormatter *_dateFormatter;
}

@property (nonatomic, retain) MWFeedParser *feedParser;
@property (nonatomic, retain) NSMutableArray *parsedItems;
@property (nonatomic, retain) NSArray *itemsToDisplay;

@property (nonatomic, retain) NSDateFormatter *dateFormatter;

@end
