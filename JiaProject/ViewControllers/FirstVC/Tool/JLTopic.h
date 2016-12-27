//
//  JLTopic.h
//  dl_jiajia
//
//  Created by 刘佳 on 16/11/4.
//  Copyright © 2016年 7k7k. All rights reserved.
//



#import <Foundation/Foundation.h>
typedef enum {
    /** 全部 */
    XMGTopicTypeAll = 1,
    
    /** 图片 */
    XMGTopicTypePicture = 10,
    
    /** 段子(文字) */
    XMGTopicTypeWord = 29,
    
    /** 声音 */
    XMGTopicTypeVoice = 31,
    
    /** 视频 */
    XMGTopicTypeVideo = 41
}JLTopicEnum;

@interface JLTopic : NSObject
/** id */
@property (nonatomic, copy) NSString *ID; // id

@property (nonatomic, assign) JLTopicEnum * topicEnum;
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

@property (nonatomic, assign) JLTopicEnum type;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) NSString * image1;

@property (nonatomic, copy) NSString * image0;

@property (nonatomic, copy) NSString * image2;

/** 是否为动态图 */
@property (nonatomic, assign) BOOL is_gif;


/***** 额外增加的属性 ******/
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentFrame;

@property (nonatomic, assign)CGFloat cellHeight;

/** 是否大图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

@end
