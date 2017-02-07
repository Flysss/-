//
//  LeftMenuViewController.m
//  NetCarOne
//
//  Created by orange on 16/9/1.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SettingViewController.h"
#import "MyWalletViewController.h"
#import "MyWalletViewController.h"
#import "RecommendViewController.h"
#import "HelpViewController.h"
#import "Personal.h"

@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *titleArr;
@property (nonatomic,assign)CGRect rect;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     UITableView *tableview =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.view.backgroundColor =[UIColor whiteColor];
    //tableView.frame= CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+120, self.view.bounds.size.width, self.view.bounds.size.height-20);
     self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource =self;
    tableview.delegate =self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableview];
    self.rect = tableview.frame;
    self.titleArr=@[@"行程",@"钱包",@"推荐",@"帮助",@"设置"];
    
    
    
    
    // Do any additional setup after loading the view.
}
#pragma mark---->设置代理权限
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseCell = @"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:reuseCell];
    if (cell==nil ) {
        cell =[[UITableViewCell alloc]initWithStyle:  UITableViewCellStyleDefault reuseIdentifier:reuseCell];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font= [UIFont systemFontOfSize:17.0];
    cell.textLabel.textColor =[UIColor greenColor];
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
     return 200;
  
}
//设置tableView的区头去除颜色
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180)];
    view.backgroundColor =[UIColor clearColor];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake((self.rect.size.width-100)/2-100,40,200, 150)];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(20, 50,30 ,50)];
    btn.layer.masksToBounds = YES;
    NSString * string = @"18756035371";
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(120, 25,0, 25)];
    [btn setTitle:[string stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    NSMutableAttributedString  * attributeString = [[NSMutableAttributedString alloc]initWithString:btn.titleLabel.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    btn.titleLabel.attributedText = attributeString;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [view addSubview:btn];
    return view;
}
#pragma mark --点击头像
-(void)clickBtn:(UIButton *)btn{

    Personal * personal = [[Personal alloc]init];
    AppDelegate *tempAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [tempAppDelegate.leftSlideVC closeLeftView];
    [tempAppDelegate.mainNaviController pushViewController:personal animated:YES];
}
#pragma mark --点击手机号
-(void)clickHeadImage:(UIPanGestureRecognizer *)pan{
    Personal * personal = [[Personal alloc]init];
    AppDelegate *tempAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [tempAppDelegate.leftSlideVC closeLeftView];
    [tempAppDelegate.mainNaviController pushViewController:personal animated:YES];
}
//实现点击跳转不同界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    switch (indexPath.row) {
        case 0:{
            //行程视图控制器
            MyWalletViewController *MyJourneyVC =[[MyWalletViewController alloc]init];
            [tempAppDelegate.leftSlideVC closeLeftView];
            [tempAppDelegate.mainNaviController pushViewController:MyJourneyVC animated:YES];
        }
            
        break;
        case 1:{
            //钱包视图控制器
            MyWalletViewController *MyWalletVC =[[MyWalletViewController alloc]init];
            [tempAppDelegate.leftSlideVC closeLeftView];
            [tempAppDelegate.mainNaviController pushViewController:MyWalletVC animated:YES];
            
        }
        break;
        case 2:{
            
            //推荐视图控制器
            RecommendViewController *RecommendVC =[[RecommendViewController alloc]init];
            [tempAppDelegate.leftSlideVC closeLeftView];
            [tempAppDelegate.mainNaviController pushViewController:RecommendVC animated:YES];
        }
            break;
        case 3:{
            //帮助视图控制器
            HelpViewController *HelpVC =[[HelpViewController alloc]init];
            [tempAppDelegate.leftSlideVC closeLeftView];
            [tempAppDelegate.mainNaviController pushViewController:HelpVC animated:YES];
        }
            break;
        case 4:{
            //设置视图控制器
            SettingViewController *SettingVC =[[SettingViewController alloc]init];
            [tempAppDelegate.leftSlideVC closeLeftView];
            [tempAppDelegate.mainNaviController pushViewController:SettingVC animated:YES];
        }
            break;
            
        default:
            break;
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
