//
//  HomeViewController.m
//  NetCarOne
//
//  Created by orange on 16/9/1.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.title = @"首页";
    UIButton *userBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x+5, self.view.bounds.origin.y+10, 50, 30)];
    [userBtn setTitle:@"用户" forState:UIControlStateNormal];
    [userBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:userBtn];
    // Do any additional setup after loading the view.
}

//打开和关闭侧边框
- (void)openOrCloseLeftList{
    AppDelegate *tempAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (tempAppDelegate.leftSlideVC.closed) {
        [tempAppDelegate.leftSlideVC openLeftView];
    }else{
        [tempAppDelegate.leftSlideVC closeLeftView];
    }
}

//视图出现的时候走的方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"视图将要出现");
    //创建appDelegate的对象
    AppDelegate *tempAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //可以进行编译
    [tempAppDelegate.leftSlideVC setPanEnabled:YES];
}

//视图将要消失的时候走的方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"视图将要消失");
    // 不可以编译状态
    AppDelegate *tempAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //可以进行编译
    [tempAppDelegate.leftSlideVC setPanEnabled:NO];
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
