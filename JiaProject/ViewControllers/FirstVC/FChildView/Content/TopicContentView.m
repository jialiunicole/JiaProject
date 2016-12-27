//
//  TopicContentView.m
//  JiaProject
//
//  Created by 刘佳 on 16/11/24.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "TopicContentView.h"
#import "SeeBigPictureVC.h"

@interface TopicContentView ()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation TopicContentView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.image.userInteractionEnabled = YES;
    [self.image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
}

-(void)imageClick
{
    if (_image.image == nil) {
        return;
    }
    SeeBigPictureVC * bigPicture = [[SeeBigPictureVC alloc]init];
    bigPicture.topic = self.topic;
    [self.window.rootViewController presentViewController:bigPicture animated:YES completion:^{
        
    }];
}
@end
