//
//  NewsController.m
//  Ting
//
//  Created by Shuwei on 15/9/16.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "NewsController.h"
#import "MainService.h"
#import "NewsBean.h"
#import "MJRefresh.h"
#import <ChameleonFramework/Chameleon.h>
#import "ShareData.h"
#import "ShowNewsController.h"

@interface NewsController ()

@end

@implementation NewsController{
    NSMutableArray *list;
    int pageno;
    NSInteger totalCnt;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"新闻";
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
    [MainService getNewsWithPageNo:(pageno-1)*20 andSuccess:^(NSMutableArray *result, NSInteger total) {
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
    if(pageno*20>totalCnt){
        [self.tableView.footer endRefreshing];
        return;
    }
    pageno++;
    [MainService getNewsWithPageNo:(pageno-1)*20 andSuccess:^(NSMutableArray *result, NSInteger total) {
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    UILabel *nameLabel =(UILabel*)[cell viewWithTag:1];
    UILabel *contentLabel=(UILabel*)[cell viewWithTag:2];
    if(nameLabel==nil){
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.view.frame.size.width-20, 22)];
        nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
        nameLabel.numberOfLines=0;
        nameLabel.tag=1;
        nameLabel.textColor=[UIColor flatWatermelonColor];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
        [cell addSubview:nameLabel];
    }
    if(contentLabel==nil){
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.view.frame.size.width-20, 22)];
        contentLabel.lineBreakMode=NSLineBreakByWordWrapping;
        contentLabel.numberOfLines=0;
        contentLabel.tag=2;
        contentLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
        contentLabel.alpha=0.7;
        [cell addSubview:contentLabel];
    }
    
    NewsBean * newsBean = [list objectAtIndex:indexPath.row];
    if(newsBean){
        nameLabel.text =newsBean.title;
        CGSize size=[newsBean.title sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:18] forKey:NSFontAttributeName]];
        CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-50;
        CGFloat line = size.width/width;
        line = [self clcLine:line];
        CGFloat height =size.height*line;
        nameLabel.frame=CGRectMake(8, 8, self.view.frame.size.width-40, height);
        contentLabel.text=newsBean.content;
        size =[newsBean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName]];
        line = [self clcLine:size.width/width];
        contentLabel.frame=CGRectMake(8, height+10, self.view.frame.size.width-40, size.height*line);
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsBean * newsBean = [list objectAtIndex:indexPath.row];
    if(newsBean){
        CGSize size=[newsBean.title sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:18] forKey:NSFontAttributeName]];
        CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-50;
        CGFloat line = size.width/width;
        line = [self clcLine:line];
        CGFloat height =size.height*line;
        size =[newsBean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName]];
        line = [self clcLine:size.width/width];
        height+=size.height*line+20;
        return height;
    }
    return 44;
}

-(CGFloat)clcLine:(CGFloat)width{
    if(width<1){
        width=1;
    }else{
        NSString *th = [NSString stringWithFormat:@"%0.0f",width];
        NSInteger t = th.integerValue;
        if(width-t>0){
            width  = t+1;
        }else{
            width = t;
        }
    }
    return width;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsBean * newsBean = [list objectAtIndex:indexPath.row];
    if(newsBean){
        [ShareData shareInstance].newsBean=newsBean;
        //UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        //backItem.tintColor=[UIColor whiteColor];
        //[self.navigationItem setBackBarButtonItem:backItem];
        //[self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
        
        ShowNewsController *show = [[ShowNewsController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
        
    }
}
@end
