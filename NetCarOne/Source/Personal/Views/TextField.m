//
//  TextField.m
//  Netcar
//
//  Created by 李徽 on 16/9/1.
//  Copyright © 2016年 李徽. All rights reserved.
//

#import "TextField.h"

@implementation TextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)leftViewRectForBounds:(CGRect)bounds{

    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y+10, bounds.size.height-20, bounds.size.height-20);
    return inset;
}

@end
