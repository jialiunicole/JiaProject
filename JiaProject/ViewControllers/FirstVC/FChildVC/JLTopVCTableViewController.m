//
//  JLTopVCTableViewController.m
//  dl_jiajia
//
//  Created by 刘佳 on 16/11/3.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "JLTopVCTableViewController.h"
#import "JLTopCell.h"
#import "JLTopic.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MJRefreshHeader.h"
#import "CommentViewController.h"

@interface JLTopVCTableViewController ()

@property (nonatomic, weak) AFHTTPSessionManager * sessionManager;

@property (nonatomic, strong) NSMutableArray * topics;

@property (nonatomic, copy) NSString * maxtime;

@end

@implementation JLTopVCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self stupTableView];
    [self setupRefresh];
}

-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}
-(void)loadNewData
{
    NSMutableDictionary * mDic = [NSMutableDictionary dictionary];
    mDic[@"a"] = self.aParam;
    mDic[@"c"] = @"data";
    mDic[@"type"] = @(self.type);
    
    __weak typeof(self) weakSelf = self;
     NSLog(@"url=%@?a=%@&c=%@&type=%@",XMGRequestURL,mDic[@"a"],mDic[@"c"],mDic[@"type"]);
    NSLog(@"%@?",XMGRequestURL);
    [self.sessionManager GET:XMGRequestURL parameters:mDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        weakSelf.topics = [JLTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.tableView reloadData];
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics
{

    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    NSLog(@"4=%@?a=%@&c=%@&type=%@&maxtime=%@", XMGRequestURL,self.aParam,@"data",[NSNumber numberWithInt:self.type],self.maxtime);
    // 发送请求
    __weak typeof(self) weakSelf = self;
    [self.sessionManager GET:XMGRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 字典数组 -> 模型数组
        NSArray *moreTopics = [JLTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.topics addObjectsFromArray:moreTopics];
        
        // 存储maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (NSString *)aParam
{
    return @"list";
}
-(void)stupTableView
{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(64+35, 0, 49, 0);    
    [self.tableView registerNib:[UINib nibWithNibName:@"JLTopCell" bundle:nil] forCellReuseIdentifier:@"JLTopCell"];
    
}
-(AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}
-(JLTopicEnum)type
{
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JLTopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JLTopCell"];
    cell.topic = self.topics[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JLTopic * topic = self.topics[indexPath.row];
    //    NSLog(@"oooooocontentFrame=%@",NSStringFromCGRect(topic.contentFrame));
    return topic.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentViewController * vc = [[CommentViewController alloc]init];
    vc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
