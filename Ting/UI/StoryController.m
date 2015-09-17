//
//  StoryController.m
//  Ting
//
//  Created by Shuwei on 15/9/17.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "StoryController.h"

@interface StoryController ()

@end

@implementation StoryController{
    UIWebView *webview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发展轨迹";
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:webview];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"story" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [webview loadHTMLString:html baseURL:baseURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
