//
//  InforController.m
//  Ting
//
//  Created by Shuwei on 15/9/17.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "InforController.h"
#import <ChameleonFramework/Chameleon.h>
#import "Common.h"

@interface InforController ()

@end

@implementation InforController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"成员资料";
    NSString *text = @"中文名:王俊凯 ；英文名：Karry ；别名：小凯、凯爷、凯宝、凯皇、凯霸； 国籍： 中国；民族： 汉族；星座：处女座； 血型：O型；身高：173cm（成长中）；体重： 51kg（成长中）；出生地：重庆市；出生日期：1999年9月21日；职业：学生、歌手、演员 ；经纪公司：北京时代峰峻文化艺术发展有限公司；代表作品：《Heart》《爱出发》《梦想起航》《魔法城堡》《青春修炼手册》《信仰之名》《样YOUNG》；主要成就：《向上吧！少年》全国100强，2014明星权力榜人气榜年度内地最受欢迎男歌手，2015两岸男神榜完美男神、年度人气大赏双料冠军，2015年6月个人微博转发创吉尼斯世界纪录；队内职务： 队长，主唱担当；就读学校：重庆八中 粉丝名称：小螃蟹；个人应援色：蓝色";
    CGSize size=[text sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName]];
    CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-20;
    CGFloat line = size.width/width;
    line = [Common clcLine:line];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame: self.view.frame];
    [self.view addSubview:scroll];
    self.view.backgroundColor=[Common colorWithHexString:@"e0e0e0"];
    
    CGFloat y=0;
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"t_1"]];
    image.frame = CGRectMake(0, y, self.view.frame.size.width, 120);
    [scroll addSubview:image];
    y+=120;
    UILabel *t1 = [[UILabel alloc] initWithFrame:CGRectMake(10, y, width, line*size.height)];
    t1.numberOfLines=0;
    t1.lineBreakMode=NSLineBreakByWordWrapping;
    t1.font = [UIFont fontWithName:@"Arial" size:16.0f];
    t1.alpha=0.7;
    t1.text=text;
    [scroll addSubview:t1];
    y+=line*size.height+5;
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"t_2"]];
    image2.frame = CGRectMake(0, y, self.view.frame.size.width, 120);
    [scroll addSubview:image2];
    y+=120;
    text = @"中文名：王源；英文名：Roy；别名：源源、源少、奶源、大源、源子、王源儿；国籍：中国；民族：汉族；星座：天蝎座；身高：167cm（成长中）；出生地：重庆；出生日期：2000年11月8日；职业：学生，歌手，演员；  经纪公司：北京时代峰峻文化艺术发展公司；代表作品：Heart、爱出发、梦想起航、魔法城堡、青春修炼手册、幸运符号、宠爱、样（YOUNG）、大梦想家；主要成就：第二届音悦V榜年度盛典，中国内地最具人气歌手奖，第二届音悦V榜年度盛典，音悦直播人气歌手奖，尖叫2015爱奇艺之夜年度盛典 最受欢迎组合奖；队内职务 主唱担当、主持担当；粉丝名称：小汤圆；个人应援色：绿色；就读学校：南开中学";
    size=[text sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName]];
    line = size.width/width;
    line = [Common clcLine:line];
    
    UILabel *t2 = [[UILabel alloc] initWithFrame:CGRectMake(10, y, width, line*size.height)];
    t2.numberOfLines=0;
    t2.lineBreakMode=NSLineBreakByWordWrapping;
    t2.font = [UIFont fontWithName:@"Arial" size:16.0f];
    t2.alpha=0.7;
    t2.text=text;
    [scroll addSubview:t2];
    y+=line*size.height+5;
    UIImageView *image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"t_3"]];
    image3.frame = CGRectMake(0, y, self.view.frame.size.width, 120);
    [scroll addSubview:image3];
    y+=120;
    text = @"中文名：易烊千玺；英文名：Jackson；别名：千千、千玺、千总、小千千、学霸千、玺宝、玺子哥；国籍：中国；民族： 汉族；星座：射手座；身高：168cm（成长ing）；出生地：湖南怀化；出生日期：2000年11月28日；职    业：学生、歌手、演员；经纪公司：北京时代峰峻文化艺术发展有限公司；代表作品：《梦想摩天楼》《Heart》《爱出发》《梦想起航》《青春修炼手册》《快乐环岛》《信仰之名》 ；队内职务：舞蹈担当；粉丝名称：千纸鹤；个人应援色：红色";
    size=[text sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName]];
    line = size.width/width;
    line = [Common clcLine:line];
    UILabel *t3 = [[UILabel alloc] initWithFrame:CGRectMake(10, y, width, line*size.height)];
    t3.numberOfLines=0;
    t3.lineBreakMode=NSLineBreakByWordWrapping;
    t3.font = [UIFont fontWithName:@"Arial" size:16.0f];
    t3.alpha=0.7;
    t3.text=text;
    [scroll addSubview:t3];
    y+=line*size.height+5;
    scroll.contentSize=CGSizeMake(self.view.frame.size.width, y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
