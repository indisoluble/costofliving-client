//
//  ConnectionDataForPrices.m
//  costofliving
//
//  Created by Enrique de la Torre on 02/05/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "ConnectionDataForPrices.h"



@interface ConnectionDataForPrices ()

#pragma mark - Properties
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address;
@property (nonatomic) BOOL allowPhotos;
@property (nonatomic) BOOL isSelected;

@end



@implementation ConnectionDataForPrices


#pragma mark - Synthesized methods
@synthesize name = _name;
@synthesize address = _address;
@synthesize allowPhotos = _allowPhotos;
@synthesize isSelected = _isSelected;


#pragma mark - Init object
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.name = [dic objectForKey:@"Name"];
        self.address = [dic objectForKey:@"Address"];
        self.allowPhotos = [[dic objectForKey:@"AllowPhotos"] boolValue];
        self.isSelected = [[dic objectForKey:@"Selected"] boolValue];
    }
    return self;
}


#pragma mark - Memory management
- (void)dealloc
{
    self.name = nil;
    self.address = nil;
    
    [super dealloc];
}


#pragma mark - ConfParameterProtocol methods
- (NSString *)text
{
    return self.name;
}

- (NSString *)detailText
{
    NSString *txt = [NSString stringWithFormat:@"Allow photos: %@ Addr: %@",
                     (self.allowPhotos ? @"YES" : @"NO"),
                     self.address];
    return txt;
}

- (BOOL)selected
{
    return self.isSelected;
}

- (void)setSelected:(BOOL)value
{
    self.isSelected = value;
}


@end
