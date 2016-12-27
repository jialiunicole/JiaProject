//
//  JLUser.h
//  JiaProject
//
//  Created by 刘佳 on 16/12/19.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end
