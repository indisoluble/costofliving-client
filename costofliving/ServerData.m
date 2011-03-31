//
//  ServerData.m
//  costofliving
//
//  Created by Enrique de la Torre on 31/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "ServerData.h"


@implementation ServerData

#pragma mark - Synthesized properties
@synthesize name = _name;
@synthesize address = _address;
@synthesize allowPhotos = _allowPhotos;


#pragma mark - Init object
- (id)initWithName:(NSString *)name Address:(NSString *)address AllowPhotos:(BOOL)allowPhotos {
    self = [super init];
    if (self) {
        _name = [name retain];
        _address = [address retain];
        _allowPhotos = allowPhotos;
    }
    return self;
}


#pragma mark - Memory management
- (void)dealloc
{
    [_name release];
    [_address release];
    
    [super dealloc];
}

@end
