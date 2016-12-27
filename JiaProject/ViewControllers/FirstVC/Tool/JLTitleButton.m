//
//  JLTitleButton.m
//  dl_jiajia
//
//  Created by 刘佳 on 16/11/4.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "JLTitleButton.h"

@implementation JLTitleButton

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
@end
