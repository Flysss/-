//
//  Singleton.h
//  Netcar
//
//  Created by 李徽 on 16/9/1.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

@property (nonatomic,strong)NSString * headImage;
@property (nonatomic,strong)NSString * nickName;
@property (nonatomic,strong)NSString * mobileNumber;
@property (nonatomic,assign)BOOL gender;
@property (nonatomic,strong)NSString * mailboxNumber;

/**
 *  个人信息单利
 *
 *  @return 单利
 */
+ (Singleton *)shareSingleton;

@end
