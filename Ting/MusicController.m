//
//  MusicController.m
//  Ting
//
//  Created by Shuwei on 15/8/19.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "MusicController.h"

@interface MusicController ()

@end

@implementation MusicController{
    UIWebView *webview;
    UIButton *backBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.view.frame;
    frame.origin.y=20;
    frame.size.height-=70;
    webview = [[UIWebView alloc] initWithFrame:frame];
    backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, frame.size.height-50, 40, 40)];
    backBtn.backgroundColor=[UIColor grayColor];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backTo:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.hidden=YES;
    [self showSV];
    [self.view addSubview:webview];
    [self.view addSubview:backBtn];
    webview.delegate = self;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //[self loadData];
    [webview loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://y.qq.com/w/singer.html?singermid=000zmpju02bEBm"]]];
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
-(IBAction)backTo:(id)sender{
    if(webview.canGoBack){
        [webview goBack];
    }else{
        backBtn.hidden=YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"var tagHead =document.getElementsByClassName(\"mod_bottom_tips\");"
     "if(tagHead!=null&&tagHead.length!=0){tagHead=tagHead[0];tagHead.parentNode.removeChild(tagHead);}"
     "document.getElementsByClassName(\"btns\")[0].style.display=\"none\";"];
    if(webView.canGoBack){
        backBtn.hidden=NO;
    }else{
        backBtn.hidden=YES;
    }
    [SVProgressHUD dismiss];
    [webview.scrollView.header endRefreshing ];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [webView stringByEvaluatingJavaScriptFromString:@"var tagHead =document.getElementsByClassName(\"mod_bottom_tips\");"
     "if(tagHead!=null&&tagHead.length!=0){tagHead=tagHead[0];tagHead.parentNode.removeChild(tagHead);}"
     "document.getElementsByClassName(\"btns\")[0].style.display=\"none\";"];
    if(webView.canGoBack){
        backBtn.hidden=NO;
    }else{
        backBtn.hidden=YES;
    }
    [SVProgressHUD dismiss];
    [webview.scrollView.header endRefreshing ];
}


@end
