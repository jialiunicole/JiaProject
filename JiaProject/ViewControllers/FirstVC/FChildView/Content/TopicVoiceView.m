//
//  TopicVoiceView.m
//  JiaProject
//
//  Created by 刘佳 on 16/11/24.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "TopicVoiceView.h"
#import "UIImageView+WebCache.h"
#import "JLTopic.h"

@interface TopicVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@end

@implementation TopicVoiceView

-(void)setTopic:(JLTopic *)topic
{
    [super setTopic:topic];
    [_image sd_setImageWithURL:[NSURL URLWithString:topic.image1]];
}

@end
