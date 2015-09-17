//
//  FileUtil.h
//  Test515
//
//  Created by silicon on 14-5-30.
//  Copyright (c) 2014年 silicon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

- (void)createPathInDocumentDirectory;

- (NSString *)pathInDocumentDirectory:(NSString *)fileName;

- (NSString *)pathInCacheDirectory:(NSString *)fileName;

- (BOOL)hasCachedImage:(NSURL *)url;

- (NSString *)pathForUrl:(NSURL *)url;

+ (FileUtil *)shareInstance;

@end
