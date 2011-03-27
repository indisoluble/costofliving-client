//
//  costoflivingAppDelegate.h
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface costoflivingAppDelegate : NSObject <UIApplicationDelegate> {
    UITabBarController *_tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) UITabBarController *tabBarController;

@end
