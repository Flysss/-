//
//  PersonalCell.h
//  Netcar
//
//  Created by 李徽 on 16/9/1.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCell : UITableViewCell

@property (nonatomic,strong)UIImageView * leftImageView;
@property (nonatomic,strong)UILabel * leftLabel;
@property (nonatomic,strong)UIColor *lineViewColor;
@property (nonatomic,assign)CGRect lineViewFrame;

@end
