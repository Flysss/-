//
//  KBnotification.m
//  NetCarOne
//
//  Created by 李徽 on 16/9/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "KBnotification.h"

@interface KBnotification()
@property (nonatomic,assign)KeyboardNotificationType type;

@end
@implementation KBnotification

+(KBnotification *)addKeyboardNotificationToVC:(UIViewController *)viewController andType:(KeyboardNotificationType)type{

    UIView * view ;
    if (viewController.tabBarController) {
        view = viewController.tabBarController.view;
    }
    else if (viewController.navigationController){
        
        view = viewController.navigationController.view;
    }
    else{
        view = viewController.view;
    }
    KBnotification * kb= [KBnotification addkeyboardNOtificationToView:view andType:type];
    
    kb.type = type;
    return kb;
}
+(KBnotification *)addkeyboardNOtificationToView:(UIView *)view andType:(KeyboardNotificationType)type{

    KBnotification * KB = [[KBnotification alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    [KB showKeyboardOnTheView:view];
    return KB;
}
-(void)showKeyboardOnTheView:(UIView *)view{

    [view addSubview:self];
   [UIView animateWithDuration:0.5 animations:^{
       self.frame = CGRectMake(0, 0, 0, 0);

   } completion:^(BOOL finished) {
       
       [super removeFromSuperview];
   }];
}
@end
