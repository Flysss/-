//
//  AboutUsViewController.m
//  NetCarOne
//
//  Created by zelend on 16/9/5.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于我们";
    
    [self initSubViews];
}

- (void)initSubViews
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UIView * footerView = [[UIView alloc]init];
    self.tableView.tableFooterView = footerView;
    
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-50, 30, 100, 100)];
    iconImg.backgroundColor = [UIColor orangeColor];
    iconImg.layer.cornerRadius = 10.0f;
    iconImg.layer.masksToBounds = YES;
    [headerView addSubview:iconImg];
    
    UILabel *versionLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-50, CGRectGetMaxY(iconImg.frame)+10,100, 20)];
    versionLab.text = [NSString stringWithFormat:@"V %@",APP_VERSION];
    versionLab.textColor = [UIColor grayColor];
    versionLab.font = DEFAULT_15;
    versionLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:versionLab];
    self.tableView.tableHeaderView = headerView;
    
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
    
    switch (indexPath.row)
    {
        case 0:
        {
            title.text = @"联系我们";
            
        }
            break;
        case 1:
        {
            title.text = @"给我评分";
            
        }
            break;
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
