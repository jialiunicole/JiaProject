//
//  SeeBigPictureVC.m
//  JiaProject
//
//  Created by 刘佳 on 16/12/12.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "SeeBigPictureVC.h"
#import "UIImageView+WebCache.h"
#import "JLTopic.h"

@interface SeeBigPictureVC ()

@end

@implementation SeeBigPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView * scroll = [[UIScrollView alloc]init];
    [self.view insertSubview:scroll atIndex:0];
    scroll.frame = [UIScreen mainScreen].bounds;
    scroll.backgroundColor = [UIColor blackColor];
    
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1]];
    [scroll addSubview:imageView];
//    imageView.frame = scroll.frame;
    
    imageView.x = 0;
    imageView.width = [UIScreen mainScreen].bounds.size.width;
    imageView.height = [UIScreen mainScreen].bounds.size.width * self.topic.height / self.topic.width;
    if (imageView.height > [UIScreen mainScreen].bounds.size.height) {
        imageView.y = 0;
        scroll.contentSize = CGSizeMake(imageView.width, imageView.height);
    }else{
        imageView.centerY = [UIScreen mainScreen].bounds.size.height * 0.5;
    }
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
