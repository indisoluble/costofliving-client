//
//  ServerData.h
//  costofliving
//
//  Created by Enrique de la Torre on 31/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServerData : NSObject {
    NSString *_name;
    NSString *_address;
    BOOL _allowPhotos;
}

@property (readonly) NSString *name;
@property (readonly) NSString *address;
@property (readonly) BOOL allowPhotos;

- (id)initWithName:(NSString *)name Address:(NSString *)address AllowPhotos:(BOOL)allowPhotos;

@end
