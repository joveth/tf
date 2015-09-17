//
//  ImageCacher.h
//  Test515
//
//  Created by silicon on 14-5-30.
//  Copyright (c) 2014年 silicon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileUtil.h"
#import "ImageLoader.h"

@protocol ImageAddDelegate<NSObject>

- (void)addImage:(UIImageView *)imageView name:(NSString *)imageName;

- (void)adjustContentSize:(BOOL)isEnd;

@end

@interface ImageCacher : NSObject{
    id<ImageAddDelegate> myDelegate;
}

@property (strong, nonatomic) FileUtil *fileUtil;

@property (strong, nonatomic) ImageLoader *imageLoader;

@property (strong, atomic) id<ImageAddDelegate > myDelegate;

- (void)cacheImage:(NSDictionary*)dic;

+ (ImageCacher *)shareInstance;

@end
