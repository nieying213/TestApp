//
//  SCAppDelegate.h
//  v2ex-iOS
//
//  Created by Singro on 3/17/14.
//  Copyright (c) 2014 Singro. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SCNavigationController.h"

@class rootViewController;
@interface V2AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, strong) SCNavigationController *navigationController;
@property (nonatomic, strong) rootViewController *rootViewController;
@property (nonatomic, assign) SCNavigationController *currentNavigationController;

@end
