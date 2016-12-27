//
//  UIBarButtonItem+JLExtension.h
//  dl_jiajia
//
//  Created by 刘佳 on 16/11/3.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JLExtension)

+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
