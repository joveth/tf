//
//  ShareData.h
//  Isaac
//
//  Created by Shuwei on 15/7/23.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsBean.h"
FOUNDATION_EXPORT NSString * const IMG_URL; 
FOUNDATION_EXPORT NSString * const IMG_BASE;
FOUNDATION_EXPORT NSString * const MUSIC_BASE;
FOUNDATION_EXPORT NSString * const NEWS_BASE;
FOUNDATION_EXPORT NSString * const NEWS_URL;
@interface ShareData : NSObject

@property(atomic,retain) NSString *title;
@property(atomic,retain) NSString *url;
@property(atomic,retain) NewsBean *newsBean;
@property(atomic,assign) BOOL flag;
+(ShareData *) shareInstance;
@end
