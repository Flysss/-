//
//  AlertView.h
//  Netcar
//
//  Created by 李徽 on 16/8/31.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^BLOCK_SHEET)(NSInteger number);
typedef enum{
    
    sureActionStyle,
    cancelActionStyle,
    bothActionStyle,
    
}ActionStyle;
@interface AlertView : NSObject


/**
 *   提示框
 *
 *  @param message  提示信息
 *  @param action   要显示的按键
 */
- (void)alertWithtitle:(NSString *)title andMessage:(NSString *)message andActionStyle:(ActionStyle)action andAlertStyle:(UIAlertControllerStyle)style andBlock:(BLOCK_SHEET)alertBlock;

- (void)actionSheetWithArray:(NSArray *)array andblock:(BLOCK_SHEET)block;


@end
