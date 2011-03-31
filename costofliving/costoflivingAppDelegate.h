//
//  costoflivingAppDelegate.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChooseServerViewController.h"
#import "ActualServerProtocol.h"
#import "ServerData.h"

@interface costoflivingAppDelegate : NSObject <UIApplicationDelegate, ActualServerProtocol> {
    UITabBarController *_tabBarController;
    ChooseServerViewController *_chooseServerViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) ChooseServerViewController *chooseServerViewController;

@end
