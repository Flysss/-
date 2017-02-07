//
//  KBnotification.h
//  NetCarOne
//
//  Created by 李徽 on 16/9/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum KeyboardNotificationType : NSUInteger{
   UIKeyboardWillShow,
   UIkeyboarWillHide,
}KeyboardNotificationType;
@interface KBnotification : UIView

+(KBnotification *)addKeyboardNotificationToVC:(UIViewController *)viewController andType:(KeyboardNotificationType)type;
@end
