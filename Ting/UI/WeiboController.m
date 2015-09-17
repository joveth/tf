//
//  WeiboController.m
//  Ting
//
//  Created by Shuwei on 15/9/17.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "WeiboController.h"
#import "MJRefresh.h"
#import "Common.h"
@interface WeiboController ()

@end

@implementation WeiboController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"官方微博";
    self.tableView.tableFooterView=[[UIView alloc] init];
    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self doRefresh];
    }];
    [self.tableView.header beginRefreshing];
    
}
-(void)doRefresh{
    sleep(5);
    [self.tableView.header endRefreshing];
    [Common showMessageWithOkButton:@"-_-！微博加载失败了！"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
@end
