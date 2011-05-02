//
//  ConnectionDataForFeeds.m
//  costofliving
//
//  Created by Enrique de la Torre on 02/05/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "ConnectionDataForFeeds.h"



@interface ConnectionDataForFeeds ()

#pragma mark - Properties
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *url;
@property (nonatomic) BOOL isSelected;

@end



@implementation ConnectionDataForFeeds


#pragma mark - Synthesized methods
@synthesize name = _name;
@synthesize url = _url;
@synthesize isSelected = _isSelected;


#pragma mark - Init object
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.name = [dic objectForKey:@"Name"];
        self.url = [dic objectForKey:@"URL"];
        self.isSelected = [[dic objectForKey:@"Selected"] boolValue];
    }
    return self;
}


#pragma mark - Memory management
- (void)dealloc
{
    self.name = nil;
    self.url = nil;
    
    [super dealloc];
}


#pragma mark - ConfParameterProtocol methods
- (NSString *)text
{
    return self.name;
}

- (NSString *)detailText
{
    NSString *txt = [NSString stringWithFormat:@"URL: %@", self.url];
    return txt;
}

- (BOOL)selected
{
    return self.isSelected;
}

- (void)setSelected:(BOOL)value
{
    //It's necessary to use a property called different from 'selected'
    //to not provate a infinite loop with this allocation
    self.isSelected = value;
}


#pragma mark - Public methods
- (NSURL *)feedURL {
    return [NSURL URLWithString:self.url];
}

@end
