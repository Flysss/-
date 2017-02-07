//
//  ChangeMobileVC.m
//  Netcar
//
//  Created by 李徽 on 16/9/2.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import "ChangeMobileVC.h"
#import "RegularCheak.h"
@interface ChangeMobileVC ()<UITextFieldDelegate>
@property (nonatomic,strong)UILabel * messageLabel;
@property (nonatomic,strong)UITextField * mobileField;
@property (nonatomic,strong)UITextField * noteField;
@property (nonatomic,strong)UIButton * testBtn;
@property (nonatomic,strong)UIButton * changeBtn;
@property (nonatomic,strong)NSString * mobileNumber;
@property (nonatomic,strong)NSString * noteString;

@end

@implementation ChangeMobileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机号";
    self.view.backgroundColor = UIColorFromRGB(0x2a5a8e);
    [self createMessageLabel];
    [self createMobileFied];
    [self createTestingBtn];
    [self createNoteField];
    [self createSureChangeBtn];
    // Do any additional setup after loading the view.
}
#pragma mark --添加描述信息框
-(void)createMessageLabel{

    self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,84, WIDTH-20, 20)];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.textColor = UIColorFromRGB(0xaaaaaa);
    self.messageLabel.font = [UIFont systemFontOfSize:17];
    if (self.isMailbox) {
        self.messageLabel.text =@"输入手机号获取验证码,进入绑定邮箱界面";
    }
    else{
        self.messageLabel.text =@"更换手机个人信息不变,下次使用新手机登陆";
    }
    [self.view addSubview:self.messageLabel];
}
#pragma  mark--添加手机号码输入框
-(void)createMobileFied{

    self.mobileField = [[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.messageLabel.frame)+30, WIDTH-210, 50)];
    self.mobileField.layer.cornerRadius=5;
    self.mobileField.layer.masksToBounds=YES;
    self.mobileField.placeholder = @"手机号";
    self.mobileField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.mobileField.layer.borderWidth = 1;
    self.mobileField.tag=100;
    [self.view addSubview:self.mobileField];
    self.mobileField.clearButtonMode =UITextFieldViewModeWhileEditing;
    self.mobileField.delegate =self;
    
}
#pragma mark --添加验证按钮
-(void)createTestingBtn{

    self.testBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.mobileField.frame)+10,CGRectGetMaxY(self.messageLabel.frame)+30,100, 50)];
    self.testBtn.layer.cornerRadius=5;
    [self.testBtn setBackgroundColor:UIColorFromRGB(0x6787AC)];
    [self.testBtn setTitleColor:UIColorFromRGB(0xCCCDCC) forState:UIControlStateNormal];
    [self.testBtn setTitle:@"验证" forState:UIControlStateNormal];
    [self.testBtn addTarget:self action:@selector(clickTestingBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testBtn];
    self.testBtn.userInteractionEnabled = NO;
}
#pragma mark --添加验证输入框
-(void)createNoteField{

    self.noteField = [[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.mobileField.frame)+10, WIDTH-100, 50)];
    self.noteField.layer.cornerRadius=5;
    self.noteField.layer.masksToBounds = YES;
    self.noteField.layer.borderWidth=1;
    self.noteField.layer.borderColor=[UIColor whiteColor].CGColor;
    self.noteField.placeholder = @"验证码";
    self.noteField.backgroundColor= [UIColor clearColor];
    self.noteField.tag=101;
    [self.view addSubview:self.noteField];
    self.noteField.delegate = self;
    
}
#pragma mark--添加确认更换按键
-(void)createSureChangeBtn{

    self.changeBtn = [[UIButton alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(self.noteField.frame)+30,WIDTH-160, 50)];
    [self.changeBtn setBackgroundColor:UIColorFromRGB(0x6787AC)];
    [self.changeBtn setTitleColor:UIColorFromRGB(0xCCCDCC) forState:UIControlStateNormal];
    self.changeBtn.layer.cornerRadius =25;
 
    [self.changeBtn addTarget:self action:@selector(clickChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeBtn];
    self.changeBtn.userInteractionEnabled =NO;
    if (self.isMailbox) {
        [self.changeBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
    else{
          [self.changeBtn setTitle:@"确认更换" forState:UIControlStateNormal];
    }
}

#pragma mark --textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField.tag==100) {
        if (textField.text.length==10) {
            [self.testBtn setBackgroundColor:[UIColor whiteColor]];
            [self.testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.testBtn.userInteractionEnabled = YES;
            self.mobileNumber = textField.text;
        }
        else{
            [self.testBtn setBackgroundColor:UIColorFromRGB(0x6787AC)];
            [self.testBtn setTitleColor:UIColorFromRGB(0xCCCDCC) forState:UIControlStateNormal];
            self.testBtn.userInteractionEnabled = NO;
        }
    }
    if (textField.tag==101) {
        if (self.mobileField.text.length==11&&textField.text.length>=3&&textField.text.length<=5) {
            [self.changeBtn setBackgroundColor:[UIColor whiteColor]];
            [self.changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.changeBtn.userInteractionEnabled=YES;
        }
        else{
        
            [self.changeBtn setBackgroundColor:UIColorFromRGB(0x6787AC)];
            [self.changeBtn setTitleColor:UIColorFromRGB(0xCCCDCC) forState:UIControlStateNormal];
            self.changeBtn.userInteractionEnabled =NO;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    if (textField.tag==101) {
        if (textField.text==0) {
            
            [self.changeBtn setBackgroundColor:UIColorFromRGB(0x6787AC)];
            [self.changeBtn setTitleColor:UIColorFromRGB(0xCCCDCC) forState:UIControlStateNormal];
            self.changeBtn.userInteractionEnabled =NO;
            
        }
    }

    return YES;
}
#pragma mark --点检验证按钮
-(void)clickTestingBtn:(UIButton *)btn{

      BOOL isMatch = [RegularCheak checkTheMobileNumber:self.mobileNumber];
    if (isMatch) {
        
        
    }
}
#pragma mark --点击确认更换按钮
- (void)clickChangeBtn:(UIButton *)btn{

    if (self.isMailbox) {
        
    }
    else{
        
    BOOL isMatch = [RegularCheak checknoteNumber:self.mobileField.text];
    BOOL isNotoMatch = [RegularCheak checknoteNumber:self.noteField.text];
    if (isMatch &&isNotoMatch) {
        
    }
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.mobileField resignFirstResponder];
    [self.noteField resignFirstResponder];
    
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
