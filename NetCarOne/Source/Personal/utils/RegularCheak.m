//
//  RegularCheak.m
//  Netcar
//
//  Created by 李徽 on 16/8/31.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import "RegularCheak.h"
#import "AlertView.h"
@implementation RegularCheak
+ (BOOL)checkTheMobileNumber:(NSString *)mobileNumber{
    
    NSString * string = @"^1+[3578]+\\d{9}";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",string];
    BOOL  isMatch = [predicate evaluateWithObject:mobileNumber];
    return isMatch;
}
+ (BOOL)checkTheMailboxNumber:(NSString *)mailbox{
    
    NSString * string = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\[A-Za-z]{2,4}";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",string];
    BOOL isMatch = [predicate evaluateWithObject:mailbox];
    return isMatch;
    
}
+(BOOL)checkTheUserIdCard:(NSString *)userIdCard{
    
    NSString * string = @"(^[0-9]{15}$)|[0-9]{17}([0-9]|X)$)";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",string];
    BOOL isMatch = [predicate evaluateWithObject:userIdCard];
    return isMatch;
}
+(BOOL)checknoteNumber:(NSString *)noteNumber{

    if (noteNumber.length==0) {
        return NO;
    }
    return YES;
}

+ (BOOL)predicateTheString:(NSString *)string predicateStyle:(PredicateStyle)style{
    RegularCheak * regular = [[RegularCheak alloc]init];
    NSArray * array = nil;
    switch (style) {
        case 0:
        {
            array = @[@"手机号不能为空",@"输入的手机号不符合规则"];
        }
            break;
        case 1:
        {
            array = @[@"邮箱帐号不能为空",@"输入的邮箱不符合规则"];
        }
            break;
        case 2:
        {
            array = @[@"身份证号码不能为空",@"身份证号码不符合要求"];
        }
            break;
        case 3:
        {
            array =@[@"验证码不能为空"];
        }
            break;
        default:
            return NO;
            break;
    }
    BOOL isMatch=  [regular alertWithArray:array andString:string andStyle:style];
    return isMatch;
}
- (BOOL)alertWithArray:(NSArray *)array andString:(NSString *)string andStyle:(PredicateStyle)style{
    
    NSString * message =nil;
    if (string.length==0) {
        message = array[0];
    }
    switch (style) {
        case 0:
        {
         if(![RegularCheak checkTheMobileNumber:string]){
                
                message = array[1];
            }
        }
            break;
        case 1:
        {
            if(![RegularCheak checkTheMailboxNumber:string]){
                
                message = array[1];
            }
        }
        case 2:
        {
            if(![RegularCheak checkTheUserIdCard:string]){
                
                message = array[1];
            }
        }
            break;
            
        default:
            break;
    }
    if (message) {
        AlertView * alert = [[AlertView alloc]init];
        [alert alertWithtitle:@"温馨提示" andMessage:message andActionStyle:sureActionStyle andAlertStyle:UIAlertControllerStyleAlert andBlock:nil];
        return NO;
    }
    else{
        
        return YES;
    }
}

@end
