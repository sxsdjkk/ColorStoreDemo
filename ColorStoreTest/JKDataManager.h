//
//  JKFileManager.h
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@class JKColor;
@interface JKDataManager : NSObject

//plist存取
+ (NSArray *)getColorArrayFromPlist; 
+ (BOOL)saveArrayToPlist:(NSArray *)array;

//序列化存取
+ (NSArray *)getColorArrayFromArchive;
+ (BOOL)saveArrayToArchive:(NSArray *)array;

//数据库存取
+ (sqlite3 *)sharedDB;
+ (NSArray *)getColorArrayFromSqlite;
+ (JKColor *)insertToDB:(JKColor *)color;
+ (void)updateToDB:(JKColor *)color;
+ (void)deleteFromDB:(JKColor *)color;

@end
