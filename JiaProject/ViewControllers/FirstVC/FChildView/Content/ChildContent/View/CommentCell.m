//
//  CommentCell.m
//  JiaProject
//
//  Created by 刘佳 on 16/12/16.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "CommentCell.h"
#import "JLComments.h"
#import "UIImageView+JLImage.h"

@interface CommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;



@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setComments:(JLComments *)comments{

    _comments = comments;
    if (comments.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comments.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
    [self.profileImageView setHeader:comments.user.profile_image];
    self.contentLabel.text = comments.content;
    self.usernameLabel.text = comments.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comments.like_count];
    if ([comments.user.sex isEqualToString:@"m"]) {
        self.sexView.image = [UIImage imageNamed:@"Profile_manIcon"];
    } else {
        self.sexView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
