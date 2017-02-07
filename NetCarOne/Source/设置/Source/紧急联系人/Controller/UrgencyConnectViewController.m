//
//  UrgencyConnectViewController.m
//  NetCarOne
//
//  Created by zelend on 16/9/5.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "UrgencyConnectViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface UrgencyConnectViewController () <UITableViewDelegate,UITableViewDataSource,ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *connectArr;

@end

@implementation UrgencyConnectViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray * array = [[NSUserDefaults standardUserDefaults] objectForKey:URGENCYCONNECTKEY];
    [_connectArr setArray:array];
    NSLog(@"%@",_connectArr);
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"紧急联系人";
    _connectArr = [NSMutableArray arrayWithCapacity:0];
    
    [self initSubViews];
}

- (void)initSubViews
{
    
    
    UILabel *introduceLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 64, WIDTH-40, 50)];
    introduceLab.text = @"为了保证您的行程安全，紧急联系人将用于自动分享行程及紧急求助功能";
    introduceLab.textColor = [UIColor grayColor];
    introduceLab.numberOfLines = 0;
    introduceLab.font = DEFAULT_11;
    
    [self.view addSubview:introduceLab];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(introduceLab.frame), WIDTH, HEIGHT-64-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
    footerView.backgroundColor = [UIColor whiteColor];
    UIButton * addConnectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH,44)];
    [addConnectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addConnectBtn setTitle:@"添加紧急联系人" forState:UIControlStateNormal];
    addConnectBtn.titleLabel.font = DEFAULT_15;
    [addConnectBtn addTarget:self action:@selector(addEmergencyConnect) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addConnectBtn];
    [addConnectBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    addConnectBtn.titleLabel.font = DEFAULT_15;
    [addConnectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    addConnectBtn.backgroundColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1];
    
    UILabel *noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(addConnectBtn.frame)+15, WIDTH-40, 15)];
    noticeLabel.text = @"最多可添加5位联系人";
    noticeLabel.textColor = [UIColor grayColor];
    noticeLabel.font = DEFAULT_11;
    [footerView addSubview:noticeLabel];
    
    self.tableView.tableFooterView = footerView;
    
    
}

//添加紧急联系人
- (void)addEmergencyConnect
{
    if ([_connectArr count] < 5)
    {
        ABPeoplePickerNavigationController *peopleNav = [[ABPeoplePickerNavigationController alloc]init];
        peopleNav.peoplePickerDelegate = self;
        [self.navigationController presentViewController:peopleNav animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"您最多可添加5位联系人" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

#pragma mark -- PeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    [self peopleSelected:person];
    
}
- (void)peopleSelected:(ABRecordRef)person
{
    //    ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
    // Get first and last names
    NSString *firstName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    //    NSString *midName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
    NSString *lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    //    NSString *PrefixProperty = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
    
    // Get mobile number
    ABMultiValueRef phonesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    NSString *phoneStr = @"";
    phoneStr = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phonesRef, 0);
    if (phoneStr.length != 0) {
        for (int i = 1; i < ABMultiValueGetCount(phonesRef); i++) {
            NSString * phone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phonesRef, i);
            if (phone) {
                phoneStr = phone;
            }
        }
    }
    
    NSString * name = @"";
    NSString * availablePhone = @"";
    if ((firstName != nil || lastName != nil)) {
        
        
        if(firstName != nil && lastName != nil) {
            name = [NSString stringWithFormat:@"%@%@", lastName,firstName];
        } else if (firstName != nil) {
            name = firstName;
        } else if (lastName != nil) {
            name = lastName;
        }
        //将特殊的字符' 转为特殊符号存储
        name = [name stringByReplacingOccurrencesOfString:@"'" withString:@"|*||*|"];
        
        availablePhone = [phoneStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        availablePhone = [availablePhone stringByReplacingOccurrencesOfString:@"+86 " withString:@""];
        availablePhone = [availablePhone stringByReplacingOccurrencesOfString:@"(" withString:@""];
        availablePhone = [availablePhone stringByReplacingOccurrencesOfString:@")" withString:@""];
        availablePhone = [availablePhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    [_connectArr addObject:@{@"name":name,@"phone":phoneStr}];
    
    [[NSUserDefaults standardUserDefaults] setObject:_connectArr forKey:URGENCYCONNECTKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
    
    
}





#pragma mark --  UITableViewDelegate/UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_connectArr count];
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
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(title.frame), 12, 120, 20)];
    detail.textColor = [UIColor grayColor];
    detail.font = DEFAULT_15;
    detail.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:detail];
    
    title.text = _connectArr[indexPath.row][@"name"];
    detail.text = _connectArr[indexPath.row][@"phone"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.connectArr removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"delete%@",_connectArr);
        
        [[NSUserDefaults standardUserDefaults] setObject:_connectArr forKey:URGENCYCONNECTKEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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
