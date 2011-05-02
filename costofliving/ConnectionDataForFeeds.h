//
//  ConnectionDataForFeeds.h
//  costofliving
//
//  Created by Enrique de la Torre on 02/05/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ConfParameterProtocol.h"


@interface ConnectionDataForFeeds : NSObject <ConfParameterProtocol> {
    NSString *_name;
    NSString *_url;
    BOOL _isSelected;
}

- (NSURL *)feedURL;

@end
