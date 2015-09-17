//
//  ImageToController.m
//  Ting
//
//  Created by Shuwei on 15/9/15.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "ImageToController.h"
#import "ImageLoader.h"
#import "MainService.h"
#import "ImagePageBean.h"
#import "ImageBean.h"
#import "MJRefresh.h"
#import <ChameleonFramework/Chameleon.h>
#import "Common.h"
@interface ImageToController ()

@end

@implementation ImageToController{
    ImageLoader *imageLoader;
    int nextPage;
    NSMutableArray *imageArr;
}
@synthesize myScrollView = _myScrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(0, 0, MY_WIDTH, MY_HEIGHT)];
    self.title=@"精美图片";
    imageLoader = [ImageLoader shareInstance];
    self.myScrollView = [MyScrollView shareInstance];
    //self.myScrollView.aDelegaet=self;
    self.myScrollView.backgroundColor=[Common colorWithHexString:@"e0e0e0"];
    nextPage = 1;
    imageArr = [[NSMutableArray alloc] init];
    [MainService getImagesWithPageNo:nextPage andSuccess:^(NSMutableArray *result) {
        if(result&&[result count]>0){
//            [imageLoader loadImage:result];
//            [self.myScrollView loadImages];
            for(int i=0;i<[result count];i++){
                NSString *imageName = [result objectAtIndex:i];
                [self.myScrollView imageStartLoading:imageName];
            }
        }
    } andError:^(NSInteger code) {
        //
    }];
//    _myScrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        nextPage=1;
//        [self startMyLoading];
//    }];
    _myScrollView.footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        nextPage++;
        [self startMyLoading];
    }];
    [self.view addSubview:_myScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)startMyLoading{
    [MainService getImagesWithPageNo:(nextPage-1)*25 andSuccess:^(NSMutableArray *result) {
        if(result&&[result count]>0){
            for(int i=0;i<[result count];i++){
                NSString *imageName = [result objectAtIndex:i];
                [self.myScrollView imageStartLoading:imageName];
            }
        }
        [_myScrollView.footer endRefreshing];
    } andError:^(NSInteger code) {
        //
        [_myScrollView.footer endRefreshing];
    }];
}

@end
