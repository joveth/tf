//
//  MyUtil.m
//  Test515
//
//  Created by silicon on 14-5-22.
//  Copyright (c) 2014年 silicon. All rights reserved.
//

#import "MyUtil.h"
//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]

@implementation MyUtil

+ (void) startLoading:(UIView *) baseView{
    UIWindow *windown = [[UIApplication sharedApplication].delegate window];
    UIView *bigView = [[UIView alloc] initWithFrame:windown.frame];
    [bigView setTag:9999];
    [bigView setUserInteractionEnabled:YES];
    [bigView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"load_back.png"]]];
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView setFrame:CGRectMake(100, 200, 40, 40)];
    [bigView addSubview:loadingView];
    [baseView addSubview:bigView];
    [loadingView startAnimating];
    [bigView release];
    [loadingView release];
    
}

+ (void) stopLoading:(UIView *) baseView{
    UIView *view = VIEWWITHTAG(baseView, 9999);
    [view removeFromSuperview];
}

@end
