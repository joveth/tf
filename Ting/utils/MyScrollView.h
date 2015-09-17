//
//  MyScrollView.h
//  Test515
//
//  Created by silicon on 14-5-15.
//  Copyright (c) 2014年 silicon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageLoader.h"
#import "MyToast.h"
#import "MyUtil.h"
#import "PhotoViewController.h"
#import "FileUtil.h"
#import "ImageCacher.h"

@protocol activityIndicatorDelegate<NSObject>

- (void)startMyLoading;

- (void)stopMyLoading;

@end

@interface MyScrollView : UIScrollView<UIScrollViewDelegate, UIGestureRecognizerDelegate, ImageAddDelegate>

@property (strong, nonatomic) id<activityIndicatorDelegate> aDelegaet;

@property (strong, nonatomic) NSMutableArray *imagesName;

@property (strong, nonatomic) NSMutableDictionary *loadedImageDic;

@property (strong, nonatomic) NSMutableArray *loadedImageArray;

@property (assign) int imgTag;

@property(strong, nonatomic) NSMutableDictionary *imgTagDic;

@property (strong, nonatomic) ImageLoader *imageLoad;

@property (assign) int page;

@property (strong, nonatomic) FileUtil *fileUtil;

@property (strong, nonatomic) ImageCacher *imageCache;

@property (strong, nonatomic) NSMutableArray *photoArray;

//左列的高度
@property (assign) float leftColumHeight;
//中列的高度
@property (assign) float midColumHeight;
//右列的高度
@property (assign) float rightColumHeight;

@property (assign) BOOL isOnce;

+ (MyScrollView *)shareInstance;
-(void)loadImages;
- (void)pullRefreshImages:(int )pageno;
- (void)imageStartLoading:(NSString *)imageName;
@end


