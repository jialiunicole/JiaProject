//
//  JLTopic.m
//  dl_jiajia
//
//  Created by 刘佳 on 16/11/4.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "JLTopic.h"
#import "MJExtension.h"

@implementation JLTopic

-(CGFloat)cellHeight{
    if (_cellHeight == 0) {
        _cellHeight = 55;//帖子文字的Y值
        
        //计算文字的高度
        CGFloat textW = [UIScreen mainScreen].bounds.size.width - 2*10;
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        _cellHeight += textH + 10;
        
        //中间内容高度
        if (self.type != XMGTopicTypeWord) {
            CGFloat contentW = textW;
            CGFloat contentH = self.height * contentW / self.width;
            if (contentH >= [UIScreen mainScreen].bounds.size.height) {
                contentH = 200;
                self.bigPicture = YES;
            }
            CGFloat contextX = 10;
            CGFloat contextY = _cellHeight;
            self.contentFrame = CGRectMake(contextX, contextY, contentW, contentH);            
            _cellHeight += contentH +10;
        }
        _cellHeight +=45;
    }
    return _cellHeight;
}

+(void)load{
[self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
    return@{
    @"ID":@"id"
    };
}];
}

@end
