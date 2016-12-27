//
//  JLComments.h
//  JiaProject
//
//  Created by 刘佳 on 16/12/19.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLUser.h"

@interface JLComments : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;

/** 文字内容 */
@property (nonatomic, copy) NSString *content;

/** 点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 语音文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;

/** 语音文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 用户 */
@property (nonatomic, strong) JLUser *user;

@end
