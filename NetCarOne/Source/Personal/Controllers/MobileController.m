//
//  MobileController.m
//  Netcar
//
//  Created by 李徽 on 16/9/2.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import "MobileController.h"
#import "ChangeMobileVC.h"
@interface MobileController ()

@property (nonatomic,strong)UILabel * mobileNumberLabel;
@property (nonatomic,strong)UIButton * changeMobileBtn;
@property (nonatomic,strong)UILabel * messageLabel;
@property (nonatomic,strong)UIImageView * headImageView;


@end

@implementation MobileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0x2a5a8e);
    [self createHeadImageView];
    [self createMobileNumberLabel];
    [self createMessageLabel];
    [self createChangeBtn];
    self.title =@"手机号";
    // Do any additional setup after loading the view.
}
#pragma mark --添加头像试图
-(void)createHeadImageView{

    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-50, 100, 100, 100)];
    self.headImageView.layer.cornerRadius =50;
    self.headImageView.layer.masksToBounds =YES;
    self.headImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headImageView];
}
#pragma mark -添加显示手机号的label
-(void)createMobileNumberLabel{

    self.mobileNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(80,CGRectGetMaxY(self.headImageView.frame)+20, WIDTH-160, 30)];
    NSString * string = [self.mobileNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    self.mobileNumberLabel.text = [NSString stringWithFormat:@"您当前的手机号为%@",string];
    self.mobileNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.mobileNumberLabel.textColor =[UIColor whiteColor];
    self.mobileNumberLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mobileNumberLabel];
}
#pragma  mark --添加提示信息框
-(void)createMessageLabel{

    self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.mobileNumberLabel.frame)+20,WIDTH-100, 60)];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.textColor = [UIColor lightGrayColor];
    self.messageLabel.text = @"更换手机个人信息不变,下次直接使用新手机号登陆";
    self.messageLabel.textColor = UIColorFromRGB(0xeeeeee);
    [self.view addSubview:self.messageLabel];
}
#pragma  mark --创建更换手机按钮
-(void)createChangeBtn{
    
    self.changeMobileBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, HEIGHT-100, WIDTH-100, 50)];
    [self.changeMobileBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
     [self.changeMobileBtn setTitle:@"更换手机号" forState:UIControlStateNormal];
    [self.changeMobileBtn setBackgroundColor:[UIColor whiteColor]];
    self.changeMobileBtn.layer.cornerRadius =25;
    self.changeMobileBtn.layer.masksToBounds =YES;
    [self.view addSubview:self.changeMobileBtn];
    [self.changeMobileBtn addTarget:self action:@selector(clickChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
  }
-(void)clickChangeBtn:(UIButton *)btn{

        ChangeMobileVC * controller =[[ChangeMobileVC alloc]init];
        controller.isMailbox = NO;
        [self.navigationController pushViewController:controller animated:YES];

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
