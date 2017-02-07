//
//  NicenameController.m
//  Netcar
//
//  Created by 李徽 on 16/9/2.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import "NicenameController.h"

@interface NicenameController ()<UITextViewDelegate>
@property (nonatomic,strong)UITextView * textView;
@property (nonatomic,strong)UIButton * sureBtn;
@property (nonatomic,strong)NSString * String;
@end

@implementation NicenameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =UIColorFromRGB(0x2a5a8e);
    [self createTextView];
    [self createSureBtn];
    self.title = @"设置昵称";
    // Do any additional setup after loading the view.
}
#pragma  mark --添加昵称试图 
-(void)createTextView{

    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0,84,WIDTH, 40)];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.layer.cornerRadius =5;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.keyboardType = UIKeyboardTypeDefault;
    self.textView.textContainerInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.textView.delegate =self;
//    self.textView.textAlignment =NSTextAlignmentLeft;
    self.textView.font = [UIFont systemFontOfSize:25];

    self.textView.text =self.nickname;
    [self.view addSubview:self.textView];
    
}
-(void)createSureBtn{

    self.sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 50, 30)];
    [self.sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(clickSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:self.sureBtn];
    self.navigationItem.rightBarButtonItem = item;
    
}
#pragma mark --点击确定
-(void)clickSureBtn:(UIButton *)btn{

    self.String = self.textView.text;
    self.block(self.String);
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationController popViewControllerAnimated:YES];
    //请求接口
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.textView resignFirstResponder];
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    CGSize size = CGSizeMake(self.textView.frame.size.width,HEIGHT/2-100);
    CGRect rect = [textView.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.textView.font} context:nil];
    float textHeight = rect.size.height+22;
    CGRect frame = textView.frame;
    frame.size.height = textHeight;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.textView.frame = frame;
        
    }];
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{

    if ([textView.text isEqualToString:self.nickname]
        ) {
        textView.text = @"";
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{

    if (textView.text.length<1){
        textView.text = self.nickname;
    }
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
