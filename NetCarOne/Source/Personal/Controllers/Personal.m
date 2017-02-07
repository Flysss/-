//
//  Personal.m
//  Netcar
//
//  Created by 李徽 on 16/9/1.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import "Personal.h"
#import "AlertView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "PersonalCell.h"
#import "Login.h"
#import "PickerView.h"
#import "NicenameController.h"
#import "MobileController.h"
#import "ChangeMobileVC.h"
@interface Personal ()<UITableViewDelegate,
                       UITableViewDataSource,
                       UINavigationControllerDelegate,
                       UIImagePickerControllerDelegate>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * tableViewDataArray;
@property (nonatomic,strong)NSMutableArray * tableViewleftLabelArray;
@property (nonatomic,strong)UIImagePickerController * imagePicker;
@property (nonatomic,strong)UIView * lineView;

@end

@implementation Personal

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self createTableView];
    self.title = @"个人中心";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --初始化数据
- (void)initData{

    NSArray *array = @[@"修改头像",@"昵称",@"手机号",@"性别",@"邮箱"];
    self.tableViewDataArray = [array mutableCopy];
    NSArray * labelArray = @[@"请输入一个有逼格的名字",@"18756035261",@"请选择",@"请选择"];
    self.tableViewleftLabelArray =[labelArray mutableCopy];
}
#pragma  mark --创建表格试图
- (void)createTableView{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =UIColorFromRGB(0x2a5a8e);
    UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:view];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
#pragma mark --创建图片采集控制器
- (void)createUIImagePickerController{

    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
}

#pragma  mark -- tableView delegate and dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.tableViewDataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row ==0) {
        
        return 88;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static  NSString * cellIdentify = @"cell";
    PersonalCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[PersonalCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColorFromRGB(0x2a5a8e);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row==0) {
        cell.leftLabel.hidden = YES;
        CGRect rect =cell.frame;
        rect.size.height=88;
        cell.frame =rect;
        cell.lineViewFrame = CGRectMake(10,cell.frame.size.height-1, WIDTH-10, 1);
    }
    else{
        cell.leftImageView.hidden =YES;
        cell.leftLabel.text = self.tableViewleftLabelArray[indexPath.row-1];
    }
    cell.textLabel.text = self.tableViewDataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    __weak typeof(self)weakSelf = self;
    switch (indexPath.row) {
        case 0:
        {
            AlertView  * sheetView = [[AlertView alloc]init];
            NSArray *  array = @[@"拍照",@"从手机相册选择",@"取消"];
            [sheetView actionSheetWithArray:array andblock:^(NSInteger number) {

                if (number ==1) {
                    [weakSelf getImageFromCameraLibrary];
                }else if(number==0){
                    
                    [weakSelf takePicture];
                }
            }];
            [self createUIImagePickerController];
        }
            break;
        case 1:
        {
            NicenameController * controller = [[NicenameController alloc]init];
            controller.nickname = self.tableViewleftLabelArray[1];
            controller.block=^(NSString * string){
            
                [weakSelf setNicenameWithString:string];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2:
        {
            
            MobileController * controller = [[MobileController alloc]init];
            controller.mobileNumber = self.tableViewleftLabelArray[1];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 3:
        {
            NSMutableArray * array = [NSMutableArray array];
            NSArray *titleArray =  @[@"男",@"女"];
            [array addObject:titleArray];
            PickerView * picker = [PickerView showPickerViewInVCTop:self withType:PickerViewTypeData];
            
            picker.dataSources = array;
            
            [picker setSelectBlock:^(NSObject *data, BOOL isSureBtn) {
                if ([data isKindOfClass:[NSArray class]]) {
                    
                    NSArray * array = (NSArray *)data;
                    NSString * string =[[NSString alloc]initWithString:array[0]];
                    [weakSelf setGenderWithSting:string];
                }
                else if ([data isKindOfClass:[NSDictionary class]]){
                    NSDictionary * diction =(NSDictionary *)data;
                    NSArray * array = [diction allKeys];
                    [weakSelf setGenderWithSting:diction[array[0]]];
                }
                else {
                    NSString * string = (NSString *)data;
                    [weakSelf setGenderWithSting:string];
                }
            }];
        }
            break;
        case 4:
        {
            ChangeMobileVC * controller = [[ChangeMobileVC alloc]init];
            controller.isMailbox = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark --从相册中获取图片
-(void)getImageFromCameraLibrary{

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return ;
    }
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}
#pragma mark --拍照
- (void)takePicture{

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
         [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
         AlertView * alert = [[AlertView alloc]init];
         [alert alertWithtitle:@"提示" andMessage:@"没有摄像头" andActionStyle:sureActionStyle andAlertStyle:UIAlertControllerStyleAlert andBlock:nil];
        
        return;
    }
    self.imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    self.imagePicker.cameraDevice =UIImagePickerControllerCameraDeviceRear;
    
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}
#pragma mark --imagePicker delegate 
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        PersonalCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.leftImageView.image = info[UIImagePickerControllerEditedImage];
    }
    else if([mediaType isEqualToString:@"public.image"]){
    
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
        }
        PersonalCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        cell.leftImageView.image = image;
    }
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --设置性别
-(void)setGenderWithSting:(NSString *)string{

    self.tableViewleftLabelArray[2] = string;

    [self.tableView reloadData];
}
#pragma mark --设置昵称
-(void)setNicenameWithString:(NSString *)string{

    self.tableViewleftLabelArray[0]=string;
    [self.tableView reloadData];
    
}

//- (UIColor *)setColorWithString:(NSString *)colorString andAlpha:(CGFloat)alpha{
//
//    NSString *  redString = [colorString substringWithRange:NSMakeRange(2, 2)];
//    NSString *  greenString = [colorString substringWithRange:NSMakeRange(4, 2)];
//    NSString * blueString = [colorString substringWithRange:NSMakeRange(5, 6)];
//    NSMutableArray * colorNumberArray = [NSMutableArray array];
//    NSArray * colorStringArray = @[redString,greenString,blueString];
//    for (int i=0;i<colorStringArray.count; i++) {
//        CGFloat red = [[colorStringArray[i] substringWithRange:NSMakeRange(0, 1)] integerValue]*16+[[colorStringArray[i] substringWithRange:NSMakeRange(1, 1)] integerValue];
//        NSString * string = [NSString stringWithFormat:@"%f",red];
//        [colorNumberArray addObject:string];
//    }
//    UIColor * color = [UIColor colorWithRed:[colorNumberArray[0] floatValue] green:[colorNumberArray[1] floatValue] blue:[colorNumberArray[2] floatValue] alpha:alpha];
//    return color;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
