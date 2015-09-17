//
//  MusicToController.m
//  Ting
//
//  Created by Shuwei on 15/9/16.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "MusicToController.h"
#import "MainService.h"
#import "MusicBean.h"
#import "MJRefresh.h"

@interface MusicToController ()

@end

@implementation MusicToController{
    NSMutableArray *list;
    int pageno;
    NSInteger totalCnt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"音乐";
    list = [[NSMutableArray alloc] init];
    self.tableView.tableFooterView=[[UIView alloc] init];
    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self doRefresh];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self doLoad];
    }];
    [self.tableView.header beginRefreshing];
    
}
-(void)doRefresh{
    pageno=1;
    [MainService getMusicsWithPageNo:(pageno-1)*30 andSuccess:^(NSMutableArray *result,NSInteger total) {
        totalCnt = total;
        if(result&&[result count]>0){
            [list removeAllObjects];
            [list addObjectsFromArray:result];
            [self.tableView reloadData];
        }
        [self.tableView.header endRefreshing];
    } andError:^(NSInteger code) {
       [self.tableView.header endRefreshing];
    }];
    
}
-(void)doLoad{
    if(pageno*30>totalCnt){
        [self.tableView.footer endRefreshing];
        return;
    }
    pageno++;
    [MainService getMusicsWithPageNo:(pageno-1)*30 andSuccess:^(NSMutableArray *result,NSInteger total) {
        if(result&&[result count]>0){
            [list addObjectsFromArray:result];
            [self.tableView reloadData];
        }
        [self.tableView.footer endRefreshing];
    } andError:^(NSInteger code) {
        [self.tableView.footer endRefreshing];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellidentifier = @"cellIdentifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.tintColor = [UIColor greenColor];
    }
    MusicBean * musicBean = [list objectAtIndex:indexPath.row];
    if(musicBean){
        cell.textLabel.text =musicBean.songname;
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MusicBean * musicBean = [list objectAtIndex:indexPath.row];
//    if(musicBean){
//
//    [MainService getLrcContent:musicBean.songid andSuccess:^(NSString *result) {
//       
//    } andError:^(NSInteger code) {
//        
//    }];
//    }
//}
@end
