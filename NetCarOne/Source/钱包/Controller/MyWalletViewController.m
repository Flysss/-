//
//  MyWalletViewController.m
//  NetCarOne
//
//  Created by zelend on 16/9/5.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "MyWalletViewController.h"

@interface MyWalletViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyWalletViewController
{
    //背景view
    UIView *_bgView;
    //余额
    UILabel *_residueLab;
    //金额
    UILabel *_moneyLab;

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"钱包";
    [self initSubviews];
    
}

- (void)initSubviews
{
    
    UIButton *questionBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-80, 64+10, 80, 20)];
    [questionBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [questionBtn setTitle:@"常见问题?" forState:UIControlStateNormal];
    questionBtn.titleLabel.font  = DEFAULT_13;
    [questionBtn addTarget:self action:@selector(checkCommonQuestion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:questionBtn];
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(110,64+20, WIDTH-220, WIDTH-220)];
    _bgView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_bgView];
    _bgView.layer.cornerRadius = (WIDTH-220)/2;
    _bgView.layer.masksToBounds = YES;
    
    _residueLab = [[UILabel alloc]initWithFrame:CGRectMake(_bgView.bounds.size.width/2-50, 15, 100, 20)];
    _residueLab.text = @"余额（元）";
    _residueLab.textColor = [UIColor whiteColor];
    _residueLab.font = DEFAULT_15;
    _residueLab.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_residueLab];
    
    _moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(_bgView.bounds.size.width/2-50, CGRectGetMaxY(_residueLab.frame), 100, 40)];
    _moneyLab.text = @"456.00";
    _moneyLab.textColor = [UIColor whiteColor];
    _moneyLab.textAlignment = NSTextAlignmentCenter;
    _moneyLab.font = DEFAULT_25;
    [_bgView addSubview:_moneyLab];
    
    UIView *gapLine = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_bgView.frame)+19, WIDTH-20, 0.5)];
    gapLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:gapLine];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgView.frame)+20, WIDTH, HEIGHT-WIDTH+220) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.scrollEnabled = NO;
}

- (void)checkCommonQuestion
{
    
}


#pragma mark --  UITableViewDelegate/UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIndentifier = @"reuseIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"充值";
            break;
        case 1:
            cell.textLabel.text = @"优惠券";
            break;
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if (IOS_VERSION >= 8.0)
    {
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
        {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
        }
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
