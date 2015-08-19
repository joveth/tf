//
//  MoreController.m
//  Ting
//
//  Created by Shuwei on 15/8/19.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "MoreController.h"
#import "Common.h"
#import "ShareData.h"

@interface MoreController ()

@end

@implementation MoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=[Common colorWithHexString:@"#e0e0e0"];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *myHeader = [[UIView alloc] init];
    UILabel *myLabel = [[UILabel alloc] init];
    [myLabel setFrame:CGRectMake(8, 0, 200, 10)];
    [myLabel setTag:101];
    [myLabel setAlpha:0.5];
    [myLabel setFont: [UIFont fontWithName:@"Arial" size:14]];
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myHeader setBackgroundColor:[Common colorWithHexString:@"#e0e0e0"]];
    [myLabel setText:[NSString stringWithFormat:@" "]];
    [myHeader addSubview:myLabel];
    
    return myHeader;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [ShareData shareInstance].flag=NO;
    if(indexPath.section==0){
        if(indexPath.row==0){
            [ShareData shareInstance].title=@"王俊凯吧";
            [ShareData shareInstance].url=@"http://tieba.baidu.com/f?kw=%E7%8E%8B%E4%BF%8A%E5%87%AF&frs=yqtb&pn=0&";
        }else if(indexPath.row==1){
            [ShareData shareInstance].title=@"王源吧";
            [ShareData shareInstance].url=@"http://tieba.baidu.com/f?kw=%E7%8E%8B%E6%BA%90&frs=yqtb&pn=0&";
        }else if(indexPath.row==2){
            [ShareData shareInstance].title=@"易烊千玺吧";
            [ShareData shareInstance].url=@"http://tieba.baidu.com/f?kw=%E6%98%93%E7%83%8A%E5%8D%83%E7%8E%BA&frs=yqtb&pn=0&";
        }
        [self performSegueWithIdentifier:@"toDetail" sender:self];
    }else if(indexPath.section==1){
        if(indexPath.row==0){
            [ShareData shareInstance].title=@"王俊凯的微博";
            [ShareData shareInstance].url=@"http://m.weibo.cn/d/tfwangjunkai?jumpfrom=weibocom";
        }else if(indexPath.row==1){
            [ShareData shareInstance].title=@"王源的微博";
            [ShareData shareInstance].url=@"http://m.weibo.cn/d/tfwangyuan?jumpfrom=weibocom";
        }else if(indexPath.row==2){
            [ShareData shareInstance].title=@"易烊千玺的微博";
            [ShareData shareInstance].url=@"http://m.weibo.cn/d/tfyiyangqianxi?jumpfrom=weibocom";
        }
        [self performSegueWithIdentifier:@"toDetail" sender:self];
    }else if(indexPath.section==2){
        if(indexPath.row==0){
            [ShareData shareInstance].title=@"百度百科之TFboys";
            [ShareData shareInstance].url=@"http://wapbaike.baidu.com/view/10832520.htm?adapt=1&fr=aladdin";
            [self performSegueWithIdentifier:@"toDetail" sender:self];
        }else if(indexPath.row==1){
            [self performSegueWithIdentifier:@"toUser" sender:self];
        }
    }
}
- (IBAction)toMoreMng:(UIStoryboardSegue *)segue
{
    [[segue sourceViewController] class];
}

@end
