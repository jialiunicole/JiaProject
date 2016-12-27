//
//  JLTabBar.m
//  dl_jiajia
//
//  Created by 刘佳 on 16/11/2.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "JLTabBar.h"

@interface JLTabBar ()

@property (nonatomic, weak) UIButton * publishButton;

@end

@implementation JLTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
        //添加发布按钮
        UIButton * publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton sizeToFit];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
    }
    return self;
}

-(void)publishClick
{

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    //设置发布按钮的位置
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    //按钮索引
    int index = 0;
    
    //按钮尺寸
    CGFloat tabBarButtonW = width / 5;
    CGFloat tabBarButtonH = height;
    CGFloat tabBarButtonY = 0;
    
    //设置4个TabBarButton的frame
    for (UIView * tabBarButton in self.subviews) {
        if (![NSStringFromClass(tabBarButton.class)isEqualToString:@"UITabBarButton"]) continue;
    //计算按钮的x值
        CGFloat tabBarButtonX = index * tabBarButtonW;
        if (index >=2 ) {
            tabBarButtonX += tabBarButtonW;
        }
        //设置按钮frame
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        
        index++;
        
    }

}

@end
