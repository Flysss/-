//
//  AppDelegate.h
//  NetCarOne
//
//  Created by orange on 16/9/1.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic )LeftSlideViewController *leftSlideVC;
@property(strong,nonatomic)UINavigationController *mainNaviController;


@end

