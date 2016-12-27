//
//  UIView+JLExtension.h
//  dl_jiajia
//
//  Created by 刘佳 on 16/11/2.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JLExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


+ (instancetype)viewFromXib;

@end
