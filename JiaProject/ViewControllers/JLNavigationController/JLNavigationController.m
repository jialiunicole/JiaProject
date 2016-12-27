//
//  JLNavigationController.m
//  dl_jiajia
//
//  Created by 刘佳 on 16/10/27.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "JLNavigationController.h"

@interface JLNavigationController ()

@end

@implementation JLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"%lu",(unsigned long)self.childViewControllers.count);
    if (self.childViewControllers.count >= 1) {
        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn sizeToFit];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        viewController.hidesBottomBarWhenPushed = YES;
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}
@end
