//
//  HomeController.m
//  Ting
//
//  Created by Shuwei on 15/9/15.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "HomeController.h"
#import "Common.h"
#import "StoryController.h"
#import "AboutMeController.h"
#import "FansController.h"
#import "WeiboController.h"
#import "ActivityController.h"

@interface HomeController ()

@end

@implementation HomeController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:1] ;
    UIImageView *image =(UIImageView *)[cell.contentView viewWithTag:2] ;
    CGFloat width=self.view.frame.size.width/3;
    if(name==nil){
        name = [[UILabel alloc] initWithFrame:CGRectMake(5, 65, width-10, 20)];
        name.tag = 1;
        name.textAlignment=NSTextAlignmentCenter;
        name.textColor = [Common colorWithHexString:@"000000"];
        
        [cell.contentView addSubview:name];
    }
    if(image==nil){
        image = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-22, 10, 44, 44)];
        image.tag = 2;
        [cell.contentView addSubview:image];
    }
    if(indexPath.row==0){
        name.text=@"新闻消息";
        image.image=[UIImage imageNamed:@"news"];
    }else if(indexPath.row==1){
        name.text=@"音乐";
        image.image=[UIImage imageNamed:@"music"];
    }else if(indexPath.row==2){
        name.text=@"活动";
        image.image=[UIImage imageNamed:@"activity"];
    }else if(indexPath.row==3){
        name.text=@"精美图片";
        image.image=[UIImage imageNamed:@"img"];
    }else if(indexPath.row==4){
        name.text=@"成员资料";
        image.image=[UIImage imageNamed:@"infor"];
    }else if(indexPath.row==5){
        name.text=@"发展轨迹";
        image.image=[UIImage imageNamed:@"story"];
    }else if(indexPath.row==6){
        name.text=@"粉丝后援";
        image.image=[UIImage imageNamed:@"qq"];
    }else if(indexPath.row==7){
        name.text=@"微博";
        image.image=[UIImage imageNamed:@"sina"];
    }else if(indexPath.row==8){
        name.text=@"关于应用";
        image.image=[UIImage imageNamed:@"more"];
    }

    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize returnSize = CGSizeMake(self.view.frame.size.width/3-10, 90);
    return returnSize;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat height=self.view.frame.size.height-280;
    return CGSizeMake(self.view.frame.size.width, height/2+20);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    if(indexPath.row==0){
        NewsController *show = [[NewsController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==1){
        MusicToController *show = [[MusicToController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==2){
        ActivityController *show = [[ActivityController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }
    else if(indexPath.row==3){
        ImageToController *show = [[ImageToController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==4){
        InforController *show = [[InforController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==5){
        StoryController *show = [[StoryController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==6){
        FansController *show = [[FansController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==7){
        WeiboController *show = [[WeiboController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==8){
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        AboutMeController *show = (AboutMeController*)[storyboard instantiateViewControllerWithIdentifier:@"AboutMe"];
        [self.navigationController pushViewController:show animated:YES];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
       reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_logo"]];
        CGRect frame =image.frame;
         CGFloat height=self.view.frame.size.height-280;
        frame.size.height=height/2;
        frame.size.width=self.view.frame.size.width;
        image.frame=frame;
        [reusableview addSubview:image];
    }
    return reusableview;
}


@end
