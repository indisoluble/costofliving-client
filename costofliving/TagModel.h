//
//  TagModel.h
//  costofliving
//
//  Created by Enrique de la Torre on 17/05/11.
//  Copyright (c) 2011 Enrique de la Torre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TagModel : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * descr;

@end
