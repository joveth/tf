//
//  ActivityController.m
//  Ting
//
//  Created by Shuwei on 15/9/17.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "ActivityController.h"
#import "MJRefresh.h"
#import "Common.h"

@interface ActivityController ()

@end

@implementation ActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"粉丝活动";
    self.tableView.tableFooterView=[[UIView alloc] init];
    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self doRefresh];
    }];
    [self.tableView.header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
-(void)doRefresh{
    sleep(5);
    [self.tableView.header endRefreshing];
    [Common showMessageWithOkButton:@"功能正在开发中！"];
}
@end
