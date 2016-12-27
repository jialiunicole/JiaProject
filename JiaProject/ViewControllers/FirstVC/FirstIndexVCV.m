//
//  FirstIndexVCV.m
//  dl_jiajia
//
//  Created by 刘佳 on 16/10/27.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "FirstIndexVCV.h"
#import "JLAllVC.h"
#import "JLVideoVC.h"
#import "JLVoiceVC.h"
#import "JLWordVC.h"
#import "JLPictureVC.h"
#import "JLTitleButton.h"

@interface FirstIndexVCV ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, weak) UIView * titlesView;

@property (nonatomic, weak) UIView * titleBottomView;

@property (nonatomic, strong) NSMutableArray * titleButtons;

@property (nonatomic, weak) JLTitleButton * titleBtn;


@end

@implementation FirstIndexVCV

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupChildVcs];
    [self setupScrollView];
    [self setupTitleView];
}

#pragma mark -lazy
-(NSMutableArray *)titleButtons{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}
-(void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}
-(void)tagClick
{
    
    
}
-(void)setupChildVcs
{
    JLAllVC * all = [[JLAllVC alloc]init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    JLVideoVC * video = [[JLVideoVC alloc]init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    JLVoiceVC * voice = [[JLVoiceVC alloc]init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    JLWordVC * word = [[JLWordVC alloc]init];
    word.title = @"段子";
    [self addChildViewController:word];
    
    JLPictureVC * picture = [[JLPictureVC alloc]init];
    picture.title = @"图片";
    [self addChildViewController:picture];
}

-(void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = XMGCommonBgColor;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count*self.view.width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}
-(void)setupTitleView
{
    UIView * titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    titleView.frame = CGRectMake(0, 64, self.view.width, 35);
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    
    for (int i = 0; i<self.childViewControllers.count; i++) {
        JLTitleButton * btn = [JLTitleButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString * titleStr = [self.childViewControllers[i] title];
        [btn setTitle:titleStr forState:UIControlStateNormal];
        [self.titleButtons addObject:btn];
        [titleView addSubview:btn];
        
        btn.x = i*titleView.width/self.childViewControllers.count;
        btn.y = 0;
        btn.width =titleView.width/self.childViewControllers.count;
        btn.height = titleView.height;
    }
    
    //标签栏底部的控制器
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor redColor];
    bottomView.height = 1;
    bottomView.y = 30;
    [titleView addSubview:bottomView];
    self.titleBottomView = bottomView;
    
    //指示器默认停留在第一个button下
    JLTitleButton * firstButton = self.titleButtons.firstObject;
    [firstButton.titleLabel sizeToFit];
    bottomView.width = firstButton.titleLabel.width;
    NSLog(@"width=%f",firstButton.titleLabel.width);
    bottomView.centerX = firstButton.centerX;
    
    [self titleBtnClick:firstButton];
}
-(void)titleBtnClick:(JLTitleButton *)btn
{

    self.titleBtn.selected = NO;
    btn.selected = YES;
    self.titleBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBottomView.width = btn.titleLabel.width;
        self.titleBottomView.centerX = btn.centerX;
    }];
    
    CGPoint point = self.scrollView.contentOffset;
    point.x = self.view.width * [self.titleButtons indexOfObject:btn];
    [self.scrollView setContentOffset:point animated:YES];
    
}

#pragma mark -当自动滚动结束时
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/scrollView.width;
    UIViewController * controller = self.childViewControllers[index];
    if (controller.isViewLoaded) {
        return;
    }
    controller.view.frame = scrollView.bounds;
    [scrollView addSubview:controller.view];
}

#pragma mark -手动拖拽
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    int i = scrollView.contentOffset.x/scrollView.width;
    [self titleBtnClick:self.titleButtons[i]];
}
@end
