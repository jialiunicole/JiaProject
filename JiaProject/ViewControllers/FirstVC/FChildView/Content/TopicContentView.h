//
//  TopicContentView.h
//  JiaProject
//
//  Created by 刘佳 on 16/11/24.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JLTopic;

@interface TopicContentView : UIView
{
   __weak UIImageView *_image;
}
@property (nonatomic, strong) JLTopic * topic;


@end
