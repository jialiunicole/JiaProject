//
//  TopicPictureView.m
//  JiaProject
//
//  Created by 刘佳 on 16/11/24.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "TopicPictureView.h"
#import "DALabeledCircularProgressView.h"
#import "UIImageView+WebCache.h"
#import "JLTopic.h"

@interface TopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation TopicPictureView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
}
-(void)setTopic:(JLTopic *)topic
{
    
    [super setTopic:topic];
    __weak typeof(self) weakSelf = self;
    [_image sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"receivedSize=%ldexpectedSize=%ld",(long)receivedSize,(long)expectedSize);
        weakSelf.progressView.hidden = NO;
        weakSelf.progressView.progress = 1.0 * receivedSize/expectedSize;
        NSLog(@"progress=%f",weakSelf.progressView.progress);
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", weakSelf.progressView.progress * 100];
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        weakSelf.progressView.hidden = YES;
    }];
    
    self.gifView.hidden = !topic.is_gif;
    self.seeBigPictureButton.hidden = !topic.isBigPicture;
    if (topic.isBigPicture) {
        _image.contentMode = UIViewContentModeTop;
        _image.clipsToBounds = YES;
    } else {
        _image.contentMode = UIViewContentModeScaleToFill;
        _image.clipsToBounds = NO;
    }

    
}
@end
