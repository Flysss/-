//
//  AlertView.m
//  Netcar
//
//  Created by 李徽 on 16/8/31.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import "AlertView.h"
@interface AlertView()
@property (nonatomic,strong)UIAlertAction * sureAction;
@property (nonatomic,strong)UIAlertAction * cancelAction;
@property (nonatomic,strong)UIWindow * windows;
@property (nonatomic,strong)UIAlertController * alertController;

@end
@implementation AlertView
-(void)alertWithtitle:(NSString *)title
           andMessage:(NSString *)message
       andActionStyle:(ActionStyle)action
        andAlertStyle:(UIAlertControllerStyle)style
        andBlock:(BLOCK_SHEET)alertBlock
{
    
    self.windows = [[UIApplication sharedApplication].delegate window];
    self.windows.backgroundColor = [UIColor colorWithWhite:0xffffff alpha:1];
    self.alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    __weak typeof (self)weakSelf = self;
    switch (action) {
        case 0:
        {
            
            self.sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (alertBlock) {
                    alertBlock(0);
                }
                [weakSelf.alertController dismissViewControllerAnimated:YES completion:nil];
                [weakSelf.windows removeFromSuperview];
                 weakSelf.windows=nil;
            }];
            [self.alertController addAction:_sureAction];
            [self.windows.rootViewController presentViewController:self.alertController animated:YES completion:nil];
            
        }
            break;
        case 1:
        {
            self.cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (alertBlock) {
                    alertBlock(1);
                }
                [weakSelf.alertController dismissViewControllerAnimated:YES completion:nil];
                [weakSelf.windows removeFromSuperview];
                weakSelf.windows=nil;
            }];
            [self.alertController addAction:self.cancelAction];
            [self.windows.rootViewController presentViewController:self.alertController animated:YES completion:nil];
        }
            break;
        case 2:
        {
            self.sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (alertBlock) {
                    alertBlock(0);
                }
                [weakSelf.alertController dismissViewControllerAnimated:YES completion:nil];
                [weakSelf.windows removeFromSuperview];
                weakSelf.windows=nil;
            }];
            self.cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (alertBlock) {
                    alertBlock(1);
                }
                [weakSelf.alertController dismissViewControllerAnimated:YES completion:nil];
                [weakSelf.windows removeFromSuperview];
                weakSelf.windows=nil;
            }];
            [self.alertController addAction:self.sureAction];
            [self.alertController addAction:self.cancelAction];
            [self.windows.rootViewController presentViewController:self.alertController animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}
- (void)actionSheetWithArray:(NSArray *)array andblock:(BLOCK_SHEET)block{

    self.windows = [[UIApplication sharedApplication].delegate window];
    self.alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<array.count; i++) {
        UIAlertAction * action = nil;

        __weak typeof(self)weakSelf =self;
        if (i==array.count-1) {
            action  = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.alertController dismissViewControllerAnimated:YES completion:nil];
                [weakSelf.windows removeFromSuperview];
                 weakSelf.windows=nil;
                 block(i);
            }];
            [self.alertController addAction:action];
            break;
        }
        action = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.alertController dismissViewControllerAnimated:YES completion:nil];
            [weakSelf.windows removeFromSuperview];
            weakSelf.windows=nil;
            block(i);
        }];
        [self.alertController addAction:action];
    }
    [self.windows.rootViewController presentViewController:self.alertController animated:YES completion:nil];
}

@end
