//
//  RegularCheak.h
//  Netcar
//
//  Created by 李徽 on 16/8/31.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    mobileNumberStyle,
    mailboxStyle,
    userIdCardStyle,
    noteNumberStyle,
}(PredicateStyle);
@interface RegularCheak : NSObject
/**
 *  checkTheMobileNumber
 *
 *  @param mobileNumber mobileNumber
 *
 *  @return isMatch
 */
+ (BOOL )checkTheMobileNumber:(NSString *)mobileNumber;

/**
 *  checkTheMailbox
 *
 *  @param mailBox mailbox
 *
 *  @return isMatch
 */
+ (BOOL)checkTheMailboxNumber:(NSString *)mailbox;

/**
 *  checkTheUserIdCard
 *
 *  @param useIdCard userIdCard
 *
 *  @return isMatch
 */
+(BOOL)checkTheUserIdCard:(NSString *)userIdCard;
/**
 *  验证验证码是否为空
 *
 *  @param noteNumber 验证码
 *
 *  @return 是否为空
 */
+(BOOL)checknoteNumber:(NSString *)noteNumber;
/**
 *  predicateString
 *
 *  @param string string
 *  @param style  style
 */
+ (BOOL)predicateTheString:(NSString *)string predicateStyle:(PredicateStyle)style;

@end
