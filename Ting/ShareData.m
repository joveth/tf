//
//  ShareData.m
//  Isaac
//
//  Created by Shuwei on 15/7/23.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import "ShareData.h"

NSString * const IMG_URL=@"http://image.baidu.com";
NSString * const IMG_BASE=@"http://image.baidu.com";
NSString * const NEWS_BASE=@"http://ixingji.com/f/miraclelist.html?appid=544&size=20";
NSString * const MUSIC_BASE=@"http://i.y.qq.com/";
NSString * const NEWS_URL=@"http://ixingji.com";
@implementation ShareData
@synthesize title;
@synthesize url;
@synthesize flag;
@synthesize newsBean;
static ShareData *instance;
+(ShareData *)shareInstance{
    if(instance==nil){
        instance = [[super alloc] init];
    }
    return instance;
}

-(id)init{
    if(self==[super init]){
    }
    return self;
}
@end
