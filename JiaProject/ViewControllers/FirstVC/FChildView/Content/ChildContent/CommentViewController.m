//
//  CommentViewController.m
//  JiaProject
//
//  Created by 刘佳 on 16/12/13.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "CommentViewController.h"
#import "AFNetworking.h"
#import "CommentCell.h"
#import "MJRefresh.h"
#import "JLTopic.h"
#import "JLComments.h"
#import "MJExtension.h"
#import "JLTopCell.h"

@interface CommentViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) AFHTTPSessionManager * manager;
@property (weak, nonatomic) IBOutlet UITableView *tv;

@property (nonatomic, strong) NSArray * hotComments;

@property (nonatomic, strong) NSMutableArray * lastedComments;

@end

@implementation CommentViewController

-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setupTableview];
    [self setupRefresh];

}
-(void)setupRefresh
{
    self.tv.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tv.mj_header beginRefreshing];
    self.tv.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}
-(void)loadNewComments
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    __weak typeof(self) weakSelf = self;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.hotComments = [JLComments mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        weakSelf.lastedComments = [JLComments mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.tv reloadData];
        [weakSelf.tv.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tv.mj_header endRefreshing];
    }];
}

-(void)loadMoreComments
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = [self.lastedComments.lastObject ID];
    __weak typeof(self) weakSelf = self;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * newArr = [JLComments mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.lastedComments addObjectsFromArray:newArr];
        [weakSelf.tv reloadData];
        // 判断评论数据是否已经加载完全
        if (self.lastedComments.count >= [responseObject[@"total"] intValue]) {
            // 已经完全加载完毕
            weakSelf.tv.mj_footer.hidden = YES;
        } else { // 应该还会有下一页数据
            // 结束刷新(恢复到普通状态，仍旧可以继续刷新)
            [weakSelf.tv.mj_footer endRefreshing];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tv.mj_footer endRefreshing];
    }];
}
-(void)setupTableview
{
    [self.tv registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
    self.tv.estimatedRowHeight = 10;
    
    JLTopCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"JLTopCell" owner:nil options:nil]lastObject];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    UIView *header = [[UIView alloc] init];
    header.height = cell.height + 2 * 10;
    [header addSubview:cell];
    self.tv.tableHeaderView = header;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.hotComments.count) {
        return self.hotComments.count;
    }return self.lastedComments.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count) {
        return 2;
    }if (self.lastedComments.count) {
        return 1;
    }return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    NSArray * commentsArr = self.lastedComments;
    if (indexPath.section == 0 && self.hotComments.count) {
        commentsArr = self.hotComments;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.comments = commentsArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView * headerView = [[UITableViewHeaderFooterView alloc]init];
    if (section == 0) {
        headerView.textLabel.text = @"最新热评";
    }else{
        headerView.textLabel.text = @"最新评论";
    }
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 设置菜单内容
    menu.menuItems = @[
                       [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)],
                       [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)],
                       [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(warn:)]
                       ];
    
    // 显示位置
    CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, 30);
    NSLog(@"rect=%@",NSStringFromCGRect(rect));
    [menu setTargetRect:rect inView:cell];
    // 显示出来
    [menu setMenuVisible:YES animated:YES];
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)ding:(UIMenuController *)menu
{
    NSLog(@"ding - %@ %@",
          self.selectedComments.user.username,
          self.selectedComments.content);
}

- (void)reply:(UIMenuController *)menu
{
    NSLog(@"reply - %@ %@",
          self.selectedComments.user.username,
          self.selectedComments.content);
}

- (void)warn:(UIMenuController *)menu
{
    NSLog(@"warn - %@ %@",
          self.selectedComments.user.username,
          self.selectedComments.content);
}

-(JLComments *)selectedComments
{
    NSIndexPath * indexPath = [self.tv indexPathForSelectedRow];
    NSArray *comments = self.lastedComments;
    NSInteger row = indexPath.row;
    if (indexPath.section == 0 && self.hotComments.count) {
        comments = self.hotComments;
    }
    return comments[row];
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
