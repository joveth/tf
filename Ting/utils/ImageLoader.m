//
//  ImageLoader.m
//  Test515
//
//  Created by silicon on 14-5-15.
//  Copyright (c) 2014年 silicon. All rights reserved.
//

#import "ImageLoader.h"
#import "MainService.h"


@interface ImageLoader ()

@end

@implementation ImageLoader
@synthesize imagesArray = _imagesArray;

+ (ImageLoader *)shareInstance{
    static ImageLoader *loader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[ImageLoader alloc] init];
    });
    return loader;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

/*加载图片*/
- (void)loadImage:(NSMutableArray *)array{
    if(!self.imagesArray){
        self.imagesArray = [[NSMutableArray alloc] init];
    }
    if([array count]>0){
        [self.imagesArray addObjectsFromArray:array];
    }
}

/*
 压缩图片，根据图片的大小按比例压缩
 width:每列试图的宽度
 返回一个UIImageView
 */
- (UIImageView *)compressImage:(float)width imageView:(UIImageView *)imgV imageName:(NSString *)name flag:(BOOL) isView{
    
    if(isView){
        float orgi_width = [imgV image].size.width;
        float orgi_height = [imgV image].size.height;
        
        //按照每列的宽度，以及图片的宽高来按比例压缩
        float new_width = width - 5;
        float new_height = (width * orgi_height)/orgi_width;
        if(new_width!=NAN&&new_height!=NAN){
        //重置imageView的尺寸
            [imgV setFrame:CGRectMake(0, 0, new_width, new_height)];
        }
        return imgV;
    }else{
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageWithContentsOfFile:name];
        
        float orgi_width = [imageV image].size.width;
        float orgi_height = [imageV image].size.height;
        
        //按照每列的宽度，以及图片的宽高来按比例压缩
        float new_width = width - 5;
        float new_height = (width * orgi_height)/orgi_width;
        
        //重置imageView的尺寸
        [imageV setFrame:CGRectMake(0, 0, new_width, new_height)];
        
        return imageV;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [_imagesArray release];
    [super dealloc];
}

@end














