//
//  JLVideoVC.m
//  dl_jiajia
//
//  Created by 刘佳 on 16/11/3.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "JLVideoVC.h"

@interface JLVideoVC ()

@end

@implementation JLVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(JLTopicEnum)type
{
    return XMGTopicTypeVideo;
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
