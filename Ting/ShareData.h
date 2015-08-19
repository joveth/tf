//
//  ShareData.h
//  Isaac
//
//  Created by Shuwei on 15/7/23.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ShareData : NSObject


@property(atomic,retain) NSString *title;
@property(atomic,retain) NSString *url;
@property(atomic,assign) BOOL flag;
+(ShareData *) shareInstance;
@end
