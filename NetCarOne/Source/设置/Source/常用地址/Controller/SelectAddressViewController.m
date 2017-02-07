//
//  SelectAddressViewController.m
//  xinantong
//
//  Created by zelend on 16/8/30.
//  Copyright © 2016年 zelend. All rights reserved.
//

#import "SelectAddressViewController.h"

@interface SelectAddressViewController () <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate>

@property (nonatomic, strong) UITextField *searchField;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tips;

@property (nonatomic, strong) AMapInputTipsSearchRequest *tipRequest;

@property (nonatomic, strong) AMapSearchAPI *searchRequest;

@end

@implementation SelectAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.searchRequest = [[AMapSearchAPI alloc]init];
    self.searchRequest.delegate = self;
    
    self.tips = [NSMutableArray arrayWithCapacity:0];
    
    [self initSubviews];
}

- (void)initSubviews
{
    
    UIButton *cityBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 27, 27)];
    [cityBtn setTitle:@"合肥" forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cityBtn.titleLabel.font = DEFAULT_13;
    [cityBtn addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cityBtn];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-37, 20, 27, 27)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = DEFAULT_13;
    [cancelBtn addTarget:self action:@selector(goBackLastView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    
    _searchField = [[UITextField alloc]init];
    _searchField.delegate = self;
    [_searchField setContentMode:UIViewContentModeLeft];
    [_searchField setPlaceholder:@"您在哪儿上车"];
    _searchField.font = DEFAULT_13;
    _searchField.frame = CGRectMake(50, 20, WIDTH-120, 44);
    self.navigationItem.titleView = _searchField;
    [_searchField becomeFirstResponder];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
}

- (void)selectCity
{
    
}

- (void)goBackLastView
{
    [_searchField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    _tipRequest = [[AMapInputTipsSearchRequest alloc]init];
    _tipRequest.keywords = textField.text;
    _tipRequest.city = @"合肥";
    _tipRequest.cityLimit = YES;
    [self.searchRequest AMapInputTipsSearch:_tipRequest];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    _tipRequest = [[AMapInputTipsSearchRequest alloc]init];
    _tipRequest.keywords = textField.text;
    _tipRequest.city = @"合肥";
    _tipRequest.cityLimit = YES;
    [self.searchRequest AMapInputTipsSearch:_tipRequest];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    _tipRequest = [[AMapInputTipsSearchRequest alloc]init];
    _tipRequest.keywords = textField.text;
    _tipRequest.city = @"合肥";
    _tipRequest.cityLimit = YES;
    [self.searchRequest AMapInputTipsSearch:_tipRequest];
    return YES;
}



#pragma  mark -- AMapSearchDelegate
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self.tips setArray:response.tips];
    
    [self.tableView reloadData];
}


#pragma mark --  UITableViewDelegate/UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tips.count;
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
    AMapTip * tip = self.tips[indexPath.row];
    
    cell.textLabel.text = tip.name;
    cell.detailTextLabel.text = tip.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchField resignFirstResponder];
    
    AMapTip *tip = self.tips[indexPath.row];
    NSLog(@"tips:%@ lat %f lon %f",tip.name,tip.location.latitude,tip.location.longitude);
    self.block(tip.name,tip.address);
    [self.navigationController popViewControllerAnimated:YES];
    
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
