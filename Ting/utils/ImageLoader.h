//
//  ImageLoader.h
//  Test515
//
//  Created by silicon on 14-5-15.
//  Copyright (c) 2014年 silicon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageLoader : UIViewController

+ (ImageLoader *) shareInstance;

- (void)loadImage:(NSMutableArray *)array;

- (UIImageView *)compressImage:(float)width imageView:(UIImageView *)imgV imageName:(NSString *)name flag:(BOOL) isView;

@property(strong, nonatomic) NSMutableArray *imagesArray;

@end
