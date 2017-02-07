//
//  Identification.m
//  Netcar
//
//  Created by 李徽 on 16/9/1.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import "Identification.h"
#import "TextField.h"
#import "RegularCheak.h"
@interface Identification ()

@property (nonatomic,strong)UIImageView * headImage;
@property (nonatomic,strong)TextField  * mobileField;
@property (nonatomic,strong)TextField  * noteField;
@property (nonatomic,strong)UIButton * noteBtn;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,assign)NSInteger number;
@property (nonatomic,strong)UIButton * loginBtn;
@property (nonnull,strong)UIView * fieldView;
@end

@implementation Identification

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor blueColor];
    [super viewDidLoad];
    [self createHeaderImage];
    [self createMobileTextField];
    [self createNoteTextField];
    [self createNoteBtn];
    [self createLoginBtn];
    
    // Do any additional setup after loading the view.
}
#pragma mark --创建头像试图
- (void)createHeaderImage{
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(125, 100, WIDTH-250,WIDTH-250)];
    _headImage.layer.cornerRadius = (WIDTH-250)/2;
    _headImage.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:_headImage];
}
#pragma mark --创建手机号输入框
- (void)createMobileTextField{
    _mobileField = [[TextField alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(_headImage.frame)+50, WIDTH-100,50)];
    _mobileField.placeholder = @"请输入手机号";
    _mobileField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    imageview.layer.cornerRadius =15;
    imageview.backgroundColor = [UIColor whiteColor];
    _mobileField.leftView  = imageview;
    _mobileField.layer.borderColor = [UIColor whiteColor].CGColor;
    _mobileField.layer.borderWidth = 1;
    _mobileField.layer.cornerRadius = 5;
    
    [self.view addSubview:_mobileField];
    
}
#pragma mark --创建验证码输入框
- (void)createNoteTextField{
    _noteField = [[TextField alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(_mobileField.frame)+10, WIDTH-170, 50)];
    UIImageView * noteImage= [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    noteImage.layer.cornerRadius =15;
    noteImage.backgroundColor = [UIColor whiteColor];
    _noteField.leftView = noteImage;
    _noteField.leftViewMode =UITextFieldViewModeAlways;
    _noteField.layer.borderWidth = 1;
    _noteField.placeholder =@"请输入验证码";
    _noteField.layer.borderColor = [UIColor whiteColor].CGColor;
    _noteField.layer.cornerRadius =5;
    [self.view addSubview:_noteField];
}
#pragma mark --创建获取验证码获取按钮
- (void)createNoteBtn{
    self.noteBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_noteField.frame)+5,CGRectGetMinY(_noteField.frame),65, 50)];
    [self.noteBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.noteBtn setBackgroundColor:[UIColor clearColor]];
    self.noteBtn.layer.cornerRadius = 5;
    self.noteBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.noteBtn.layer.borderWidth = 1;
    self.noteBtn.layer.cornerRadius = 5;
    self.noteBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.noteBtn.titleLabel.adjustsFontSizeToFitWidth =YES;
    [self.noteBtn addTarget:self action:@selector(clickNoteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_noteBtn];
}
#pragma  mark --创建确认认证按钮
- (void)createLoginBtn{
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(50,CGRectGetMaxY(_noteField.frame)+50, WIDTH-100, 50)];
    [_loginBtn setTitle:@"确认认证" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _loginBtn.layer.borderWidth = 1;
    _loginBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _loginBtn.layer.cornerRadius =25;
    [_loginBtn addTarget:self action:@selector(clickIdentification:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    [self.view addSubview:_loginBtn];
}
#pragma mark --点击获取验证码
- (void)clickNoteBtn:(UIButton *)btn{
    
    if (btn.selected ^=1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
        [self.timer setFireDate:[NSDate distantPast]];
        self.noteBtn.userInteractionEnabled = NO;
        self.number = 60;
    }
    else{
        self.timer = nil;
        self.number = 60;
        [self.noteBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        self.noteBtn.userInteractionEnabled = YES;
    }
}
- (void)startTimer{
    
    self.number--;
    if (self.number==0) {
        self.noteBtn.userInteractionEnabled = YES;
        [self.noteBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        self.timer = nil;
    }
    else{
        [self.noteBtn setTitle:[NSString stringWithFormat:@"(%zi)",self.number] forState:UIControlStateNormal];
    }
}
#pragma mark--点击确认认证
- (void)clickIdentification:(UIButton *)btn{

    BOOL isMatch = [RegularCheak predicateTheString:self.mobileField.text predicateStyle:mobileNumberStyle];
    if (isMatch) {
        BOOL isMatch = [RegularCheak predicateTheString:self.noteField.text predicateStyle:mobileNumberStyle];
        if (isMatch) {
            
        }
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
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
