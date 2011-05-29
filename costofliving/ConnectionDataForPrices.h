//
//  ConnectionDataForPrices.h
//  costofliving
//
//  Created by Enrique de la Torre on 02/05/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ConfParameterProtocol.h"


@interface ConnectionDataForPrices : NSObject <ConfParameterProtocol> {
    NSString *_name;
    NSString *_address;
    BOOL _allowPhotos;
    BOOL _isSelected;
}

- (NSURL *)url;

@end
