//
//  ShowNewsController.m
//  Ting
//
//  Created by Shuwei on 15/9/16.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "ShowNewsController.h"
#import "MBProgressHUD.h"
#import "MainService.h"
#import "ShareData.h"

@interface ShowNewsController ()

@end

@implementation ShowNewsController{
    UIWebView *webview;
    NewsBean *newsBean;
    MBProgressHUD *hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:webview];
    hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    hud.labelText = @"加载中";
    [hud show:YES];
    
    [self.navigationController.view addSubview:hud];
    newsBean = [ShareData shareInstance].newsBean;
    self.title=newsBean.title;
    [MainService getNewsContent:newsBean.url andSuccess:^(NSString *result) {
        [webview loadHTMLString:result baseURL:nil];
        [hud hide:YES];
    } andError:^(NSInteger code) {
        [hud hide:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
