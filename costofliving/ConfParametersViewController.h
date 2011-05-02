//
//  ConfParametersViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 02/05/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ConfParametersDelegate <NSObject>

- (void)parameterChanged:(id)newValue;

@end



@interface ConfParametersViewController : UITableViewController {
    NSMutableArray *_confParameters;
    
    id<ConfParametersDelegate> _delegate;
}

@property (nonatomic, assign) id<ConfParametersDelegate> delegate;

- (NSArray *)parameters;

@end
