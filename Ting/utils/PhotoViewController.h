//
//  PhotoViewController.h
//  Test515
//
//  Created by silicon on 14-5-22.
//  Copyright (c) 2014年 silicon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSString *imageName;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray *imageArray;

@property (assign) NSUInteger page;

@end
