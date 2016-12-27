//
//  UIImageView+JLImage.m
//  JiaProject
//
//  Created by 刘佳 on 16/11/24.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "UIImageView+JLImage.h"
#import "UIImage+JLExtension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (JLImage)
- (void)setHeader:(NSString *)url
{
    __weak typeof(self) weakSelf = self;
    UIImage * placeholder = [[UIImage imageNamed:@"defaultUserIcon"]circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) {
            return ;
        }
        weakSelf.image = [image circleImage];
    }];
}

@end
