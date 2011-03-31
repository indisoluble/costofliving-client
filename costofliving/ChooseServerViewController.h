//
//  ChooseServerViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 31/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ServerData.h"


@interface ChooseServerViewController : UITableViewController {
    NSUInteger _selected;
    NSMutableArray *_servers;
    
    NSUInteger _selectedTemp;
}

- (ServerData *)actualServer;

@end
