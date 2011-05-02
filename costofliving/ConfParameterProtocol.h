//
//  ConfParameterProtocol.h
//  costofliving
//
//  Created by Enrique de la Torre on 02/05/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ConfParameterProtocol <NSObject>

- (id)initWithDictionary:(NSDictionary *)dic;

- (NSString *)text;
- (NSString *)detailText;
- (BOOL)selected;
- (void)setSelected:(BOOL)value;

@end
