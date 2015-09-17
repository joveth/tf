//
//  ImageCacher.m
//  Test515
//
//  Created by silicon on 14-5-30.
//  Copyright (c) 2014年 silicon. All rights reserved.
//

#import "ImageCacher.h"

@implementation ImageCacher
@synthesize fileUtil = _fileUtil;
@synthesize imageLoader = _imageLoader;
@synthesize myDelegate = _myDelegate;

+ (ImageCacher *)shareInstance{
    static ImageCacher *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)init{
    self = [super init];
    if(self){
        self.fileUtil = [FileUtil shareInstance];
        self.imageLoader = [ImageLoader shareInstance];
    }
    return self;
}

- (void)cacheImage:(NSDictionary*)dic{
    NSURL *url = [dic objectForKey:@"URL"];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if(!data){
        return;
    }
    NSString *fileName = [_fileUtil pathForUrl:url];
    if(data){
        [fileManage createFileAtPath:fileName contents:data attributes:nil];
    }
    
    UIImageView *imageView = [dic objectForKey:@"imageView"];
    imageView.image = [UIImage imageWithData:data];
    imageView = [_imageLoader compressImage:MY_WIDTH/3 imageView:imageView imageName:nil flag:YES];
    [self.myDelegate addImage:imageView name:fileName];
    [self.myDelegate adjustContentSize:NO];
}

- (void)dealloc{
    [super dealloc];
}

@end
