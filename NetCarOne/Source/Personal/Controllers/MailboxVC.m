//
//  MailboxVC.m
//  NetCarOne
//
//  Created by 李徽 on 16/9/5.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "MailboxVC.h"

@interface MailboxVC ()

@property (nonatomic,strong)UILabel * messageLabel;
@property (nonatomic,strong)UITextView * mobileNumber;
@property (nonatomic,strong)UITextView * noteNubmer;
@property (nonatomic,strong)UIButton * testBtn;
@property (nonatomic,strong)UIButton * sureBtn;

@end

@implementation MailboxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark --创建手机号输入框
-(void)createMobileNumberTextView{

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
