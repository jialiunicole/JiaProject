//
//  UIImage+JLExtension.m
//  JiaProject
//
//  Created by 刘佳 on 16/11/25.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "UIImage+JLExtension.h"

@implementation UIImage (JLExtension)
-(instancetype)circleImage
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
    
}
@end
