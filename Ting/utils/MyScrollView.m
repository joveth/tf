//
//  MyScrollView.m
//  Test515
//
//  Created by silicon on 14-5-15.
//  Copyright (c) 2014年 silicon. All rights reserved.
//

#import "MyScrollView.h"
#import "MainService.h"

#define COORDINATE_X_LEFT 5
#define COORDINATE_X_MIDDLE MY_WIDTH/3 + 5
#define COORDINATE_X_RIGHT MY_WIDTH/3 * 2 + 5
#define PAGESIZE 25

@interface MyScrollView ()

@end

@implementation MyScrollView
@synthesize isOnce = _isOnce;
@synthesize imagesName = _imagesName;
@synthesize loadedImageDic = _loadedImageDic;
@synthesize leftColumHeight = _leftColumHeight;
@synthesize midColumHeight = _midColumHeight;
@synthesize rightColumHeight = _rightColumHeight;
@synthesize loadedImageArray = _loadedImageArray;
@synthesize imgTag = _imgTag;
@synthesize imgTagDic = _imgTagDic;
@synthesize imageLoad = _imageLoad;
@synthesize page = _page;
@synthesize fileUtil = _fileUtil;
@synthesize imageCache = _imageCache;
@synthesize photoArray = _photoArray;
//@synthesize aDelegaet;

+ (MyScrollView *)shareInstance{
    static MyScrollView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithFrame:CGRectMake(0, 0, MY_WIDTH, MY_HEIGHT)];
        });
    
    return instance;
}

/*
 初始化scrollView的委托以及背景颜色，不显示它的水平，垂直显示条
 */
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.delegate = self;
        self.backgroundColor = [UIColor blackColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.isOnce = YES;
        self.loadedImageDic = [[NSMutableDictionary alloc] init];
        self.loadedImageArray = [[NSMutableArray alloc] init];
        self.imgTagDic = [[NSMutableDictionary alloc] init];
        self.photoArray = [[NSMutableArray alloc] init];

        //初始化列的高度
        self.leftColumHeight = 3.0f;
        self.midColumHeight = 3.0f;
        self.rightColumHeight = 3.0f;
        self.imgTag = 10086;
        self.page = 1;
        
        self.fileUtil = [FileUtil shareInstance];
        self.imageCache = [ImageCacher shareInstance];
        
        _imageCache.myDelegate = self;
        
        [self initWithPhotoBox];
    }
    
    return self;
}

/*
 将scrollView界面分为大小相等的3个部分，每个部分为一个UIView, 并设置每一个UIView的tag
 */
- (void)initWithPhotoBox{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_WIDTH/3, self.frame.size.height)];
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(leftView.frame.origin.x + MY_WIDTH/3, 0, MY_WIDTH/3,
                                                                  self.frame.size.height)];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(middleView.frame.origin.x + MY_WIDTH/3, 0, MY_WIDTH/3,
                                                                 self.frame.size.height)];
    //设置三个部分的tag
    leftView.tag = 100;
    middleView.tag = 101;
    rightView.tag = 102;
    
    //设置背景颜色
    [leftView setBackgroundColor:[UIColor clearColor]];
    [middleView setBackgroundColor:[UIColor clearColor]];
    [rightView setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:leftView];
    [self addSubview:middleView];
    [self addSubview:rightView];
    
    self.imageLoad = [ImageLoader shareInstance];
    
    //当前为第一页
    self.page = 0;
}

/*
 * @brief 图片加载通用函数
 * @parma imageName 图片名
 */
-(void)loadImages{
    //第一次加载图片
    if(_imageLoad.imagesArray){
        for(int i = 0; i < [_imageLoad.imagesArray count]; i++){
        NSString *imageName = [_imageLoad.imagesArray objectAtIndex:i];
        [self imageStartLoading:imageName];
        }
    }
}

- (void)imageStartLoading:(NSString *)imageName{
    NSURL *url = [NSURL URLWithString:imageName];
    if([_fileUtil hasCachedImage:url]){
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *path = [_fileUtil pathForUrl:url];
        imageView = [_imageLoad compressImage:MY_WIDTH/3 imageView:nil imageName:path flag:NO];
        [self addImage:imageView name:path];
        [self adjustContentSize:NO];
    }else{
        UIImageView *imageView = [[UIImageView alloc] init];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:url, @"URL",
                             imageView, @"imageView", nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher shareInstance] withObject:dic];
    }
}


/*
 *调整scrollview
 */
- (void)adjustContentSize:(BOOL)isEnd{
    UIView *leftView = [self viewWithTag:100];
    UIView *middleView = [self viewWithTag:101];
    UIView *rightView = [self viewWithTag:102];
    
    if(_leftColumHeight >= _midColumHeight && _leftColumHeight >= _rightColumHeight){
        self.contentSize = leftView.frame.size;
    }else{
        if(_midColumHeight >= _rightColumHeight){
            self.contentSize = middleView.frame.size;
        }else{
            self.contentSize = rightView.frame.size;
        }
    }
}

/*
 *得到最短列的高度
 */
- (float)getTheShortColum{
    if(_leftColumHeight <= _midColumHeight && _leftColumHeight <= _rightColumHeight){
        return _leftColumHeight;
    }else{
        if(_midColumHeight <= _rightColumHeight){
            return _midColumHeight;
        }else{
            return _rightColumHeight;
        }
    }
}

/*
 *添加一张图片
 *规则：根据每一列的高度来决定，优先加载列高度最短的那列
 *重新设置图片的x,y坐标
 *imageView:图片视图
 *imageName:图片名
 */
- (void)addImage:(UIImageView *)imageView name:(NSString *)imageName{
    if(!imageView){
        return;
    }
    //图片是否加载
    if([self.loadedImageDic objectForKey:imageName]){
        return;
    }
    
    //若图片还未加载则保存
    [self.loadedImageDic setObject:imageView forKey:imageName];
    [self.loadedImageArray addObject:imageView];
    [_photoArray addObject:imageName];
    
    [self imageTagWithAction:imageView name:imageName];
    
    float width = imageView.frame.size.width;
    float height = imageView.frame.size.height;
    
    //判断哪一列的高度最低
    if(_leftColumHeight <= _midColumHeight && _leftColumHeight <= _rightColumHeight){
        UIView *leftView = [self viewWithTag:100];
        [leftView addSubview:imageView];
        //重新设置坐标
        [imageView setFrame:CGRectMake(2, _leftColumHeight, width, height)];
        _leftColumHeight = _leftColumHeight + height + 3;
        [leftView setFrame:CGRectMake(0, 0, MY_WIDTH/3, _leftColumHeight)];
    }else{
        if(_midColumHeight <= _rightColumHeight){
            UIView *middleView = [self viewWithTag:101];
            [middleView addSubview:imageView];

            [imageView setFrame:CGRectMake(2, _midColumHeight, width, height)];
            _midColumHeight = _midColumHeight + height + 3;
            [middleView setFrame:CGRectMake(MY_WIDTH/3, 0, MY_WIDTH/3, _midColumHeight)];
        }else{
            UIView *rightView = [self viewWithTag:102];
            [rightView addSubview:imageView];

            [imageView setFrame:CGRectMake(2, _rightColumHeight, width, height)];
            _rightColumHeight = _rightColumHeight + height + 3;
            [rightView setFrame:CGRectMake(2 * MY_WIDTH/3, 0, MY_WIDTH/3, _rightColumHeight)];
        }
    }
}


/*
 将图片tag保存，以及为UIImageView添加事件响应
 */
- (void)imageTagWithAction:(UIImageView *)imageView name:(NSString *)imageName{
    //将要显示图片的tag保存
    imageView.tag = self.imgTag;
    [self.imgTagDic setObject:imageName forKey:[NSString stringWithFormat:@"%ld", (long)imageView.tag]];
    self.imgTag++;
    
    //图片添加事件响应
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickWithTag:)];
    tapRecognizer.delegate = self;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapRecognizer];
    [tapRecognizer release];
}


/*
     //若三列中最短列距离底部高度超过30像素，则请求加载新的图片
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //可视检查
    //[self checkImageIsVisible];
//    if((self.contentOffset.y + self.frame.size.height) - [self getTheShortColum] > 30){
//        
//        if(_aDelegaet){
//            [_aDelegaet startMyLoading];
//        }else{
//            [self pullRefreshImages:self.page];
//        }
//        
//    }
}


/*
 上拉时加载新的图片
 */
- (void)pullRefreshImages:(int )pageno{
    self.page = pageno;
    int index = self.page *PAGESIZE;
    NSUInteger imgNum = [self.imageLoad.imagesArray count];
    
    if(index >= imgNum){
        //图片加载完毕
        [self adjustContentSize:YES];
    }else{
        if((imgNum - self.page*PAGESIZE) > PAGESIZE){
            for (int i = index; i < PAGESIZE; i++) {
                NSString *imageName = [_imageLoad.imagesArray objectAtIndex:i];
                [self imageStartLoading:imageName];
            }
        }else{
            for (int i = index; i < imgNum; i++) {
                NSString *imageName = [_imageLoad.imagesArray objectAtIndex:i];
                [self imageStartLoading:imageName];
            }
        }
        self.page++;
    }
}

/*
 检查图片是否可见，如果不在可见视线内，则把图片替换为nil
 */
- (void)checkImageIsVisible{
    for (int i = 0; i < [_loadedImageArray count]; i++) {
        UIImageView *imgView = [_loadedImageArray objectAtIndex:i];
        
        if((self.contentOffset.y - imgView.frame.origin.y) > imgView.frame.size.height ||
           imgView.frame.origin.y > (self.frame.size.height + self.contentOffset.y)){
            //不显示图片
            imgView.image = nil;
        }else{
            //重新根据tag值显示图片
            NSString *imageName = [self.imgTagDic objectForKey:[NSString stringWithFormat:@"%ld", (long)imgView.tag]];
            if((NSNull *)imageName == [NSNull null]){
                return;
            }
            
            UIImageView *view = [_imageLoad compressImage:MY_WIDTH/3 imageView:nil imageName:imageName flag:NO];
            imgView.image = view.image;
        }
    }
}

//点击图片事件响应
- (void)imageClickWithTag:(UITapGestureRecognizer *)sender{
    UIImageView *view = (UIImageView *)sender.view;
    NSString *imageName = [self.imgTagDic objectForKey:[NSString stringWithFormat:@"%ld", (long)view.tag]];
    
    PhotoViewController *photoView = [[PhotoViewController alloc] init];
    photoView.imageArray = _photoArray;
    photoView.imageName = imageName;
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:photoView.view];
}


- (void)dealloc{
    [_imagesName release];
    [_imgTagDic release];
    [_loadedImageArray release];
    [_imageCache release];
    [_fileUtil release];
    [_imageLoad release];
    [_photoArray release];
    [super dealloc];
}

@end
















