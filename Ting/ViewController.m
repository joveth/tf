//
//  ViewController.m
//  Ting
//
//  Created by Shuwei on 15/8/17.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"


@interface ViewController ()

@end

@implementation ViewController{
    UIWebView *webview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.tintColor = [Common colorWithHexString:@"00bb9c"];
    [self.tabBarController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"home2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    [[[self.tabBarController.viewControllers objectAtIndex:0] tabBarItem] setSelectedImage:[UIImage imageNamed:@"home2"]];
    [[[self.tabBarController.viewControllers objectAtIndex:1] tabBarItem] setSelectedImage:[UIImage imageNamed:@"sina"]];
    [[[self.tabBarController.viewControllers objectAtIndex:2] tabBarItem] setSelectedImage:[UIImage imageNamed:@"music"]];
    [[[self.tabBarController.viewControllers objectAtIndex:3] tabBarItem] setSelectedImage:[UIImage imageNamed:@"more"]];
    CGRect frame = self.view.frame;
    frame.origin.y=20;
    frame.size.height-=70;
    webview = [[UIWebView alloc] initWithFrame:frame];
    [self showSV];
    [self.view addSubview:webview];
    webview.delegate = self;
    //    [NetCall queryTieWithPageNo:1 andCallBack:^(NSMutableArray *_ret) {
    //
    //    }];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [webview loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://tieba.baidu.com/f?kw=tfboys"]]];
    // 添加下拉刷新控件
    webview.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [webview reload];
    }];
}
-(void)showSV{
    dispatch_async(dispatch_get_main_queue(),^ {
        [SVProgressHUD show];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"var tagHead =document.getElementsByClassName(\"client_ad_topBanner\");"
     "if(tagHead!=null&&tagHead.length!=0){tagHead=tagHead[0];tagHead.parentNode.removeChild(tagHead);}"
     ];
    
    [SVProgressHUD dismiss];
    [webview.scrollView.header endRefreshing ];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [webView stringByEvaluatingJavaScriptFromString:@"var tagHead =document.getElementsByClassName(\"client_ad_topBanner\");"
    "if(tagHead!=null&&tagHead.length!=0){tagHead=tagHead[0];tagHead.parentNode.removeChild(tagHead);}"
    ];
    [SVProgressHUD dismiss];
    [webview.scrollView.header endRefreshing ];
}

@end
