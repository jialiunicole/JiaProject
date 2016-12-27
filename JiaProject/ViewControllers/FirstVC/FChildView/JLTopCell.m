//
//  JLTopCell.m
//  JiaProject
//
//  Created by 刘佳 on 16/11/24.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "JLTopCell.h"
#import "TopicPictureView.h"
#import "TopicVideoView.h"
#import "TopicVoiceView.h"
#import "UIImageView+JLImage.h"
#import "JLTopic.h"

@interface JLTopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (nonatomic, weak) TopicPictureView * pictureView;
@property (nonatomic, weak) TopicVideoView * videoView;
@property (nonatomic, weak) TopicVoiceView * voiceView;



@end

@implementation JLTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(TopicPictureView *)pictureView
{
    if (!_pictureView) {
        TopicPictureView * pictureView = [TopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

-(TopicVoiceView *)voiceView
{
    if (!_voiceView) {
        TopicVoiceView * voiceView = [TopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

-(TopicVideoView *)videoView{
    if (!_videoView) {
        TopicVideoView * videoView = [TopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

-(void)setTopic:(JLTopic *)topic
{
    _topic = topic;
    [self.profileImageView setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    if (topic.type == XMGTopicTypePicture) {
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.contentFrame;
        self.pictureView.topic = topic;
        
    }else if (topic.type == XMGTopicTypeVoice){
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.contentFrame;
        self.voiceView.topic = topic;
    }else if (topic.type == XMGTopicTypeVideo) { // 视频
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentFrame;
        self.videoView.topic = topic;
        
    } else if (topic.type == XMGTopicTypeWord) { // 文字
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }


}

- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder

{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%f万",number/10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
