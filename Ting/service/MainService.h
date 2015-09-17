//
//  MainService.h
//  FirstDemo
//
//  Created by jov jov on 6/6/15.
//  Copyright (c) 2015 jov jov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestKit.h"
#import "ImageBean.h"
#import "ImagePageBean.h"
#import "MusicBean.h"
#import "NewsBean.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"
#import "IGHTMLQuery.h"

@interface MainService : NSObject
typedef void (^CallBack)(NSArray *result);
typedef void (^CallBackMutable)(NSMutableArray *result);
typedef void (^CallBackString)(NSString *result);
typedef void (^ErrorCallBack)(NSInteger code);
typedef void (^CallBackMutAndPage)(NSMutableArray *result,NSInteger total);
+(void) getImagesWithPageNo:(NSInteger )pageno andSuccess:(CallBackMutable)callback andError:(ErrorCallBack)err;
+(void) getMusicsWithPageNo:(NSInteger )pageno andSuccess:(CallBackMutAndPage)callback andError:(ErrorCallBack)err;
+(void) getNewsWithPageNo:(NSInteger )pageno andSuccess:(CallBackMutAndPage)callback andError:(ErrorCallBack)err;
+(void) getNewsContent:(NSString *)url andSuccess:(CallBackString)callback andError:(ErrorCallBack)err;
+(void) getLrcContent:(NSNumber *)num andSuccess:(CallBackString)callback andError:(ErrorCallBack)err;

@end
