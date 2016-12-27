//
//  FooterView.m
//  JiaProject
//
//  Created by 刘佳 on 16/12/22.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "FooterView.h"
#import "MyButton.h"
#import "Square.h"
#import "MJExtension.h"

@implementation FooterView
-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:(CGRect)frame]){
        // 请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        
        NSLog(@"url=%@?a=square&c=topic",XMGRequestURL);
        // 发送请求
        __weak typeof(self) weakSelf = self;
        [[AFHTTPSessionManager manager] GET:XMGRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            [weakSelf createSquares:[Square mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]]];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    return self;
}

-(void)createSquares:(NSArray *)arr{
    
    int count = 4;
    CGFloat buttonWidth = self.width/count;
    CGFloat buttonHeight = buttonWidth;
    
    for (int i = 0; i<arr.count; i++) {
        
        MyButton * btn = [MyButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        CGFloat buttonX = (i%count)* buttonWidth;
        CGFloat buttonY = (i/count)* buttonHeight;
        btn.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        
        btn.square = arr[i];
        self.height = CGRectGetMaxY(btn.frame);
        
    }
    UITableView * view = (UITableView *)self.superview;
    view.tableFooterView = self;
    
}
@end
