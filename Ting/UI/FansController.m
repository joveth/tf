//
//  FansController.m
//  Ting
//
//  Created by Shuwei on 15/9/17.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "FansController.h"
#import "MJRefresh.h"
#import "Common.h"

@interface FansController ()

@end

@implementation FansController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"粉丝后援";
    self.tableView.tableFooterView=[[UIView alloc] init];
    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self doRefresh];
    }];
    [self.tableView.header beginRefreshing];
}
-(void)doRefresh{
    sleep(5);
    [self.tableView.header endRefreshing];
    [Common showMessageWithOkButton:@"查询失败了，返回内容为空！"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
@end
