//
//  SelectAddressViewController.h
//  xinantong
//
//  Created by zelend on 16/8/30.
//  Copyright © 2016年 zelend. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectAddressBlock)(NSString *name,NSString* address);

@interface SelectAddressViewController : UIViewController


@property (nonatomic, copy)SelectAddressBlock block;

@end
