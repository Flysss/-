//
//  SettingViewController.m
//  NetCarOne
//
//  Created by zelend on 16/9/5.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "SettingViewController.h"
#import "UrgencyConnectViewController.h"
#import "SecuirtyJourneyViewController.h"
#import "FrequentAddressViewController.h"
#import "BlackListViewController.h"
#import "AboutUsViewController.h"

@interface SettingViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *array;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    self.array = @[@"紧急联系人",@"行程安全",@"常用地址",@"黑名单",@"关于我们"];
    
    [self initSubViews];
    
}

- (void)initSubViews
{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    footerView.backgroundColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1];
    self.tableView.tableFooterView = footerView;
    
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame = CGRectMake(40, HEIGHT-70, WIDTH-80, 40);
    [quitBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    quitBtn.titleLabel.font = DEFAULT_17;
    [quitBtn addTarget:self action:@selector(quitLogin) forControlEvents:UIControlEventTouchUpInside];
    quitBtn.backgroundColor = [UIColor orangeColor];
    quitBtn.layer.cornerRadius = 10.0f;
    quitBtn.layer.masksToBounds = YES;
    [self.view addSubview:quitBtn];
}

- (void)quitLogin
{
    
}

#pragma mark --  UITableViewDelegate/UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld%ld",indexPath.section,indexPath.row]];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 100, 20)];
    title.textColor = [UIColor grayColor];
    title.font = DEFAULT_15;
    [cell.contentView addSubview:title];
    title.text = self.array[indexPath.section];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            UrgencyConnectViewController *vc = [[UrgencyConnectViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            SecuirtyJourneyViewController *vc = [[SecuirtyJourneyViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            FrequentAddressViewController *vc = [[FrequentAddressViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            BlackListViewController *vc = [[BlackListViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            AboutUsViewController *vc = [[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    if (IOS_VERSION >= 8.0)
    {
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
        {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 0)];
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
