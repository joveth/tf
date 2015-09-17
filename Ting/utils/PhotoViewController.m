//
//  PhotoViewController.m
//  Test515
//
//  Created by silicon on 14-5-22.
//  Copyright (c) 2014年 silicon. All rights reserved.
//

#import "PhotoViewController.h"
#import "ImageLoader.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController
@synthesize scrollView = _scrollView;
@synthesize imageArray = _imageArray;
@synthesize page = _page;

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
    [self.view setFrame:CGRectMake(0, 0, MY_WIDTH, MY_HEIGHT)];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, MY_WIDTH, MY_HEIGHT)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(MY_WIDTH * [_imageArray count], MY_HEIGHT);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
    //图片添加事件响应
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePhotoView)];
    tapRecognizer.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    [_scrollView addGestureRecognizer:tapRecognizer];
    [tapRecognizer release];
    
    [self loadingImages];
}

- (void)viewWillAppear:(BOOL)animated{
    [_scrollView setContentOffset:CGPointMake([_imageArray indexOfObject:_imageName] * MY_WIDTH, 0)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//关闭
- (void)closePhotoView{
    [self.view removeFromSuperview];
}

- (void)dealloc{
    [_scrollView release];
    [super dealloc];
}

//用户回归显示
- (void)loadingImages{
    //加载图片
    for(int i = 0; i < [_imageArray count]; i++){
        NSString *picName = [_imageArray objectAtIndex:i];
        UIImageView *imageV = [[ImageLoader shareInstance] compressImage:MY_WIDTH imageView:nil imageName:picName flag:NO];
        
        float width = imageV.image.size.width;
        float height = imageV.image.size.height;
        
        float new_width = MY_WIDTH;
        float new_height = (MY_WIDTH * height)/width;
        float y=0;
        if(new_height<MY_HEIGHT){
            y=(MY_HEIGHT-new_height)/2;
        }
        imageV.frame = CGRectMake(MY_WIDTH * i, y, new_width, new_height);
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:imageV];
        [imageV release];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{

}

@end
