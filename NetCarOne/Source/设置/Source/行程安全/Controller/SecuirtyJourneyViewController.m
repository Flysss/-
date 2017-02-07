//
//  SecuirtyJourneyViewController.m
//  NetCarOne
//
//  Created by zelend on 16/9/5.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "SecuirtyJourneyViewController.h"

@interface SecuirtyJourneyViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation SecuirtyJourneyViewController

{
    UISwitch *_autoShare;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"行程安全";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [self.dataArr setArray:[[NSUserDefaults standardUserDefaults] objectForKey:URGENCYCONNECTKEY]];
    
    [self initSubViews];
    
}

- (void)initSubViews
{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    UILabel * noticeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH-20, 20)];
    noticeLab.text = @"该时间段内，行程将会以短信的形式自动分享给紧急联系人";
    noticeLab.textColor = [UIColor grayColor];
    noticeLab.font = DEFAULT_11;
    noticeLab.numberOfLines = 0;
    [footerView addSubview:noticeLab];
    self.tableView.tableFooterView = footerView;
    
}

#pragma mark --  UITableViewDelegate/UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return [self.dataArr count]+1;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
            
        default:
            return 0;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld%ld",indexPath.section,indexPath.row]];
        
    }
    
    if (indexPath.section == 0)
    {
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 100, 20)];
        title.textColor = [UIColor grayColor];
        title.font = DEFAULT_15;
        title.text = @"自动分享行程";
        [cell.contentView addSubview:title];
        
        _autoShare = [[UISwitch alloc]initWithFrame:CGRectMake(WIDTH-60, 7, 50, 30)];
        _autoShare.on = YES;
        [cell.contentView addSubview:_autoShare];
        
    }
    else if (indexPath.section == 1)
    {
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 150, 20)];
        title.textColor = [UIColor grayColor];
        title.font = DEFAULT_15;
        [cell.contentView addSubview:title];
        
        if (indexPath.row < [self.dataArr count])
        {
            title.text = self.dataArr[indexPath.row][@"name"];
            UIButton * stateBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-30, 12, 20, 20)];
            stateBtn.tag = 100 + indexPath.row;
            [cell.contentView addSubview:stateBtn];
            if (indexPath.row == 0)
            {
                stateBtn.backgroundColor = [UIColor orangeColor];
            }
            else
            {
                stateBtn.backgroundColor = [UIColor grayColor];
            }
        }
        else
        {
            title.text = @"管理紧急联系人";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    else if (indexPath.section == 2)
    {
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 100, 20)];
        title.textColor = [UIColor grayColor];
        title.font = DEFAULT_15;
        title.text = @"自动分享行程";
        [cell.contentView addSubview:title];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIButton * selectTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-130, 12, 100, 20)];
        [selectTimeBtn setTitle:@"22:00-05:00" forState:UIControlStateNormal];
        [selectTimeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        selectTimeBtn.titleLabel.font = DEFAULT_11;
        [selectTimeBtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:selectTimeBtn];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)selectTime:(UIButton*)sender
{
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        if (indexPath.row < self.dataArr.count)
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UIButton * btn = [cell viewWithTag:100+indexPath.row];
            btn.backgroundColor = [UIColor orangeColor];
        }
        else
        {
            
        }
    }
    else if (indexPath.section == 2)
    {
        
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1)
    {
        if (indexPath.row < self.dataArr.count)
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UIButton *btn = [cell viewWithTag:100+indexPath.row];
            btn.backgroundColor = [UIColor grayColor];
            
        }
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 20;
    }
    else if (section == 1)
    {
        return 30;
    }
    else
    {
        return 30;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 30)];
        view.backgroundColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 120, 15)];
        label.textColor = [UIColor lightGrayColor];
        label.text = @"自动分享给";
        label.font = DEFAULT_11;
        [view addSubview:label];
        return view;
    }
    else
    {
        return nil;
    }
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 0)];
    }
    if (IOS_VERSION >= 8.0)
    {
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
        {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, 20, 0, 0)];
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
