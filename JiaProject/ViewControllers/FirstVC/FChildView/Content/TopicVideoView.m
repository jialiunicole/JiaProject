//
//  TopicVideoView.m
//  JiaProject
//
//  Created by 刘佳 on 16/11/24.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "TopicVideoView.h"
#import "UIImageView+WebCache.h"
#import "JLTopic.h"

@interface TopicVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;



@end

@implementation TopicVideoView

-(void)setTopic:(JLTopic *)topic
{
    [super setTopic:topic];
    [_image sd_setImageWithURL:[NSURL URLWithString:topic.image1]];
    
}

@end
