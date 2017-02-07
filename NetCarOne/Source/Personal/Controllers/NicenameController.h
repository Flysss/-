//
//  NicenameController.h
//  Netcar
//
//  Created by 李徽 on 16/9/2.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BLOCK_NICENAME)(NSString *string);

@interface NicenameController : UIViewController

@property (nonatomic,copy)BLOCK_NICENAME block;
@property (nonatomic,copy)NSString * nickname;

@end
