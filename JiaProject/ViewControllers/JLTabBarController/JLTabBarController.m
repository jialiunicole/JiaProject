//
//  JLTabBarController.m
//  dl_jiajia
//
//  Created by 刘佳 on 16/10/27.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "JLTabBarController.h"
#import "FirstIndexVCV.h"
#import "SecondIndexVC.h"
#import "ThreeIndexVC.h"
#import "FourIndexVC.h"
#import "JLNavigationController.h"
#import "JLTabBar.h"

@interface JLTabBarController ()

@end

@implementation JLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVcs];
    [self setupTabBar];
}
//添加所有的子控制器
-(void)setupChildVcs
{
    [self setupChildVC:[[FirstIndexVCV alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_icon"];
    [self setupChildVC:[[SecondIndexVC alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVC:[[ThreeIndexVC alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVC:[[FourIndexVC alloc]init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}

//处理tabbar
-(void)setupTabBar
{
    [self setValue:[[JLTabBar alloc] init] forKey:@"tabBar"];
}
//添加一个字控制器
-(void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    JLNavigationController * nav = [[JLNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed: image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed: selectedImage];
    
    
}
@end
