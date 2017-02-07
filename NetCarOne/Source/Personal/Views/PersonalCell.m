//
//  PersonalCell.m
//  Netcar
//
//  Created by 李徽 on 16/9/1.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import "PersonalCell.h"
@interface PersonalCell()
@property (nonatomic,strong)UIView * lineView;


@end
@implementation PersonalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if(self ==[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    
        [self addUI];
    }
    return self;
}
- (void)addUI{

    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-94,20,44,44)];
    self.leftImageView.layer.cornerRadius=22;
    self.leftImageView.layer.masksToBounds = YES;
    self.leftImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.leftImageView];
    self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-250, 10, 200, 24)];
    self.leftLabel.font = [UIFont systemFontOfSize:15];
    self.leftLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.leftLabel];
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(10, self.frame.size.height-1,WIDTH-10, 1)];
    self.lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.lineView];
}
- (void)setLineViewColor:(UIColor *)lineViewColor{

    self.lineView.backgroundColor =lineViewColor;
    
}
- (void)setLineViewFrame:(CGRect)lineViewFrame{

    self.lineView.frame = lineViewFrame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
