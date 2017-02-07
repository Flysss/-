//
//  FrequentAddressViewController.m
//  NetCarOne
//
//  Created by zelend on 16/9/5.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "FrequentAddressViewController.h"
#import "SelectAddressViewController.h"

@interface FrequentAddressViewController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FrequentAddressViewController

{
    NSString *_homeStr;
    NSString *_companyStr;
    NSString *_homeAddress;
    NSString *_companyAddress;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"常用地址";
    
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
    
    UIImageView *homeImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    [cell.contentView addSubview:homeImg];
    
    UILabel *homeLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(homeImg.frame)+10, 12, 100, 20)];
    homeLab.textColor = [UIColor lightGrayColor];
    homeLab.font = DEFAULT_13;
    [cell.contentView addSubview:homeLab];
    
    
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(homeLab.frame),8, 200,15)];
    address.textColor = [UIColor orangeColor];
    address.font = DEFAULT_13;
    [cell.contentView addSubview:address];
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(homeLab.frame), CGRectGetMaxY(address.frame), 200, 15)];
    detail.textColor = [UIColor grayColor];
    detail.font = DEFAULT_11;
    [cell.contentView addSubview:detail];
    
    if (indexPath.row == 0)
    {
        homeLab.text = @"设置家的地址";
        homeImg.backgroundColor = [UIColor orangeColor];
        if (_homeStr != nil)
        {
            address.text = _homeStr;
            detail.text = _homeAddress;
            homeLab.frame = CGRectMake(CGRectGetMaxX(homeImg.frame)+10, 12, 30, 20);
            homeLab.text = @"家";
            address.frame = CGRectMake(CGRectGetMaxX(homeLab.frame),8, 200,15);
            detail.frame = CGRectMake(CGRectGetMaxX(homeLab.frame), CGRectGetMaxY(address.frame), 200, 15);
        }
    }
    else
    {
        homeImg.backgroundColor = [UIColor blueColor];
        homeLab.text = @"设置公司地址";
        if (_companyStr != nil)
        {
            address.text = _companyStr;
            detail.text = _companyAddress;
            homeLab.frame = CGRectMake(CGRectGetMaxX(homeImg.frame)+10, 12, 30, 20);
            homeLab.text = @"公司";
            address.frame = CGRectMake(CGRectGetMaxX(homeLab.frame),8, 200,15);
            detail.frame = CGRectMake(CGRectGetMaxX(homeLab.frame), CGRectGetMaxY(address.frame), 200, 15);
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SelectAddressViewController *vc = [[SelectAddressViewController alloc]init];
    vc.block = ^(NSString *name, NSString *address)
    {
        if (indexPath.row == 0)
        {
            _homeStr = name;
            _homeAddress = address;
            
        }
        else
        {
            _companyStr = name;
            _companyAddress = address;
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.row == 0)
        {
            _homeStr = nil;
            _homeAddress = nil;
            
        }
        else
        {
            _companyStr = nil;
            _companyAddress = nil;
        }
        [self.tableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
    
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
