//
//  UIBarButtonItem+JLExtension.m
//  dl_jiajia
//
//  Created by 刘佳 on 16/11/3.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "UIBarButtonItem+JLExtension.h"

@implementation UIBarButtonItem (JLExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc]initWithCustomView:button];
}

@end
