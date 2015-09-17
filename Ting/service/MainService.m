//
//  MainService.m
//  FirstDemo
//
//  Created by jov jov on 6/6/15.
//  Copyright (c) 2015 jov jov. All rights reserved.
//

#import "MainService.h"
#import "ShareData.h"

@implementation MainService

+(void) getImagesWithPageNo:(NSInteger )pageno andSuccess:(CallBackMutable)callback andError:(ErrorCallBack)err{
    
    NSURL *baseURL = [NSURL URLWithString:IMG_BASE];
    RKObjectManager *manager =  [RKObjectManager managerWithBaseURL:baseURL];
    RKObjectMapping *WebResponse = [RKObjectMapping mappingForClass:[ImagePageBean class]];
    [WebResponse addAttributeMappingsFromDictionary:@{
                                                      @"listNum" : @"listNum"
                                                      }];
    RKObjectMapping *pageBean = [RKObjectMapping mappingForClass:[ImageBean class]];
    
    [pageBean addAttributeMappingsFromDictionary:@{
                                                   @"thumbURL" : @"thumbURL",
                                                   @"objURL" :@"objURL"
                                                   }];
    NSString *path=[NSString stringWithFormat:@"/i?tn=baiduimagejson&width=&height=&word=TFboys&rn=25&pn=%ld",pageno] ;
    [WebResponse addRelationshipMappingWithSourceKeyPath:@"data" mapping:pageBean];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:WebResponse
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:path
                                                                                           keyPath:nil
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    manager.HTTPClient.allowsInvalidSSLCertificate=YES;
    //[RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/javascript"];
    //[manager setAcceptHeaderWithMIMEType:@"text/javascript"];
    [manager addResponseDescriptor:responseDescriptor];
    //    [manager getObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *result)
    //     {
    //
    //         if(callback){
    //             NSArray *respArray = [result array];
    //             callback(respArray);
    //         }
    //     }  failure:^(RKObjectRequestOperation * operation, NSError * error)
    //     {
    //         if(err){
    //             NSInteger code = operation.HTTPRequestOperation.response.statusCode;
    //             err(code);
    //         }
    //
    //     }];
    
    //    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[ImageBean class]];
    //    [mapping addAttributeMappingsFromDictionary:@{
    //                                                  @"listNum" : @"listNum"
    //                                                  }];
    //    [mapping addRelationshipMappingWithSourceKeyPath:@"data" mapping:pageBean];
    //    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    //    RKResponseDescriptor *responseDescriptor1 = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:path keyPath:nil statusCodes:statusCodes];
    //
    //    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:IMG_BASE]];
    //    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor1]];
    //    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
    //    operation.HTTPRequestOperation.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //
    //    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
    //        ImagePageBean *article = [result firstObject];
    //        NSLog(@"Mapped the article: %@", article);
    //    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    //        NSLog(@"Failed with error: %@", [error localizedDescription]);
    //    }];
    //    [operation start];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client setDefaultHeader:@"Accept" value:@"text/javascript"];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    client.allowsInvalidSSLCertificate=YES;
    [client postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *ret = (NSDictionary *)responseObject;
        NSArray *data = [ret objectForKey:@"data"];
        NSMutableArray *urls = [[NSMutableArray alloc] init];
        if(data&&[data count]>0){
            for(int i=0;i<[data count];i++){
                NSDictionary *obj = [data objectAtIndex:i];
                NSString *url = [obj objectForKey:@"objURL"];
                if(url){
                    [urls addObject:url];
                }
            }
        }
        if(callback){
            callback(urls);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(err){
            NSInteger code = operation.response.statusCode;
            err(code);
        }
    }];
}
+(void) getMusicsWithPageNo:(NSInteger )pageno andSuccess:(CallBackMutAndPage)callback andError:(ErrorCallBack)err{
    NSURL *baseURL = [NSURL URLWithString:MUSIC_BASE];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client setDefaultHeader:@"Accept" value:@"text/html"];
    [client setDefaultHeader:@"Pragma" value:@"no-cache"];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    client.allowsInvalidSSLCertificate=YES;
    NSString *path=[NSString stringWithFormat:@"v8/fcg-bin/fcg_v8_singer_track_cp.fcg?g_tk=5381&loginUin=0&hostUin=0&format=jsonp&inCharset=GB2312&outCharset=utf-8&notice=0&platform=yqq&jsonpCallback=MusicJsonCallback&needNewCode=0&singermid=000zmpju02bEBm&order=listen&begin=%ld&num=30&songstatus=1",pageno] ;
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString* newStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        newStr = [newStr stringByReplacingOccurrencesOfString:@"MusicJsonCallback(" withString:@""];
        newStr = [newStr substringToIndex:newStr.length-1];
        NSLog(@"ret=%@",newStr);
        NSData *temp = [newStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *ret =[NSJSONSerialization JSONObjectWithData:temp options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data = [ret objectForKey:@"data"];
        NSNumber *total =[data objectForKey:@"total"];
        NSArray *list = [data objectForKey:@"list"];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        if(list&&[list count]>0){
            for(int i=0;i<[list count];i++){
                NSDictionary *obj = [list objectAtIndex:i];
                MusicBean *mus = [[MusicBean alloc] init];
                NSDictionary *son =[obj objectForKey:@"musicData"];
                mus.albumname=[son objectForKey:@"albumname"];
                mus.songname=[son objectForKey:@"songname"];
                mus.songmid=[son objectForKey:@"songmid"];
                mus.songid =[son objectForKey:@"songid"];
                [result addObject:mus];
            }
        }
        if(callback){
            callback(result,[total integerValue]);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(err){
            NSInteger code = operation.response.statusCode;
            err(code);
        }
    }];
}
+(void) getNewsWithPageNo:(NSInteger )pageno andSuccess:(CallBackMutAndPage)callback andError:(ErrorCallBack)err{
    @try {
        NSString *URI_NEWS = [NSString stringWithFormat:@"%@&start=%ld",NEWS_BASE,pageno];
        NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:URI_NEWS]];
        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
        NSArray *aArray = [xpathParser searchWithXPathQuery:@"//article[@class='miracle ']"];
        NSArray *pages = [xpathParser searchWithXPathQuery:@"//div[@id='pages']"];
        NSInteger total=0;
        NSMutableArray *result = [[NSMutableArray alloc] init];
        if ([aArray count] > 0) {
            for(int i=0;i<[aArray count];i++){
                TFHppleElement *contentEle = [aArray objectAtIndex:i];
                NSArray *contentArray = [contentEle searchWithXPathQuery:@"//div[@class='title']"];
                if([contentArray count]>0){
                    TFHppleElement *conEle = [contentArray objectAtIndex:0];
                    NSArray *last = [conEle searchWithXPathQuery:@"//a"];
                    NSArray *des = [conEle searchWithXPathQuery:@"//h4"];
                    if([last count]>0){
                        TFHppleElement *lastEle = [last objectAtIndex:0];
                        NSString  *url =[[lastEle attributes] objectForKey:@"href"];
                        NSString  *title =[lastEle text];//TFboys★150916【新闻】
                        if([title containsString:@"新闻"]){
                            NewsBean *bean = [[NewsBean alloc] init];
                            bean.url = url;
                            NSInteger index =[title rangeOfString:@"★"].location;
                            title = [title substringFromIndex:index+1];
                            title = [title stringByReplacingOccurrencesOfString:@"【新闻】" withString:@"☞"];
                            bean.title = title;
                            if([des count]>0){
                                TFHppleElement *desEle = [des objectAtIndex:0];
                                bean.content=[desEle text];
                                bean.content = [bean.content stringByReplacingOccurrencesOfString:@"[cp]" withString:@""];
                                bean.content = [bean.content stringByReplacingOccurrencesOfString:@"[/cp]" withString:@""];
                            }
                            [result addObject:bean];
                        }
                    }
                }
            }
        }
        if([pages count]>0){
            TFHppleElement *pageEle = [pages objectAtIndex:0];
            NSArray *pageArr = [pageEle searchWithXPathQuery:@"//a"];
            if([pageArr count]>0){
                TFHppleElement *pEle = [pageArr objectAtIndex:[pageArr count]-1];
                NSString  *url =[[pEle attributes] objectForKey:@"href"];
                NSInteger index =[url rangeOfString:@"start="].location;
                if(index!=NSNotFound){
                    url = [url substringFromIndex:index];
                    url = [url stringByReplacingOccurrencesOfString:@"start=" withString:@""];
                    url = [url stringByReplacingOccurrencesOfString:@"&size=20" withString:@""];
                    total=[url integerValue];
                    NSLog(@"totalPage=%@",url);
                }
            }
        }
        if(callback){
            callback(result,total);
        }
    }
    @catch (NSException *exception) {
        if(err){
            err(404);
        }
    }
    @finally {
        
    }
}
+(void) getNewsContent:(NSString *)url andSuccess:(CallBackString)callback andError:(ErrorCallBack)err{
    @try {
        NSString *URI_NEWS = [NSString stringWithFormat:@"%@%@",NEWS_URL,url];
        NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:URI_NEWS]];
        IGHTMLDocument* node = [[IGHTMLDocument alloc] initWithHTMLData:htmlData encoding:nil error:nil];
        NSString* html = [[[node queryWithCSS:@".contentInner"] firstObject] html];
        html = [html stringByReplacingOccurrencesOfString:@"[cp]" withString:@""];
        html = [html stringByReplacingOccurrencesOfString:@"[/cp]" withString:@""];
        NSString *css =@"<style >img{max-width:100%;}</style>";
        css = [css stringByAppendingString:html];
        if(callback){
            callback(css);
        }
    }
    @catch (NSException *exception) {
        if(err){
            err(404);
        }
    }
    @finally {
        
    }
}
+(void) getLrcContent:(NSNumber *)num andSuccess:(CallBackString)callback andError:(ErrorCallBack)err{

    @try {
        
        NSString *URI_NEWS = [NSString stringWithFormat:@"http://music.qq.com/miniportal/static/lyric/%d/%d.xml",num.intValue%100,num.intValue];
        NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:URI_NEWS]];
        IGHTMLDocument* node = [[IGHTMLDocument alloc] initWithHTMLData:htmlData encoding:nil error:nil];
        NSString* html = [node innerHtml];
        NSLog(@"html=%@",html);
        
        if(callback){
            callback(html);
        }
    }
    @catch (NSException *exception) {
        if(err){
            err(404);
        }
    }
    @finally {
        
    }
}
@end
