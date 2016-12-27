//
//  MyButton.m
//  JiaProject
//
//  Created by 刘佳 on 16/12/23.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel * lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(0, 0, 30, 30);
        lab.text = @"你好呀";
        [self addSubview:lab];
    }
    return self;

}
@end
