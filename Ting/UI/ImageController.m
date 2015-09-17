//
//  ImageController.m
//  Ting
//
//  Created by Shuwei on 15/9/15.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "ImageController.h"
@interface PhotoCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *photo;

@end

@implementation PhotoCell

@end
@interface ImageController ()

@end

@implementation ImageController{
    NSMutableArray *imagUrls;
    SDWebImageManager *manager;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    DDCollectionViewFlowLayout *layout = [[DDCollectionViewFlowLayout alloc] init];
    layout.delegate = self;
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    imagUrls = [[NSMutableArray alloc] initWithObjects:@"http://img.my.csdn.net/uploads/201309/01/1378037235_3453.jpg",
                @"http://img.my.csdn.net/uploads/201309/01/1378037235_9280.jpg",
                @"http://img.my.csdn.net/uploads/201309/01/1378037234_3539.jpg", nil];
     manager = [SDWebImageManager sharedManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [imagUrls count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UIImageView *image =(UIImageView *)[cell.contentView viewWithTag:2] ;
    CGFloat width=self.view.frame.size.width/2-2;
    if(image==nil){
        image = [[UIImageView alloc] initWithFrame:CGRectMake(1, 5, width, 50)];
        image.tag = 2;
        [cell.contentView addSubview:image];
    }

    NSString *imgurl = [imagUrls objectAtIndex:indexPath.row];
    if(imgurl){
        NSURL *url = [NSURL URLWithString:imgurl];
        [manager downloadImageWithURL:url
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *ret, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (ret) {
                                    // do something with image
                                    image.image =ret;
                                    
                                }
                            }];
    }
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(DDCollectionViewFlowLayout *)layout numberOfColumnsInSection:(NSInteger)section{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.view.frame.size.width/2, 60);
}


@end
