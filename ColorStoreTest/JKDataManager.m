//
//  JKFileManager.m
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import "JKDataManager.h"
#import "JKColor.h"

static sqlite3 *db = nil;

@implementation JKDataManager : NSObject 


+ (NSArray *)getColorArrayFromPlist; {
  
  NSMutableArray *resultArray = [NSMutableArray array];
  NSArray *array = [NSArray arrayWithContentsOfFile:[self plistPath]];
  
  for (NSDictionary *dic in array) {
    
    JKColor *color = [[JKColor alloc] initWithDictionary:dic];
    [resultArray addObject:color];
  }
  
  return resultArray;
}

+ (BOOL)saveArrayToPlist:(NSArray *)array {
  
  if (![[NSFileManager defaultManager] fileExistsAtPath:[self plistPath]]) {
    
    [[NSFileManager defaultManager] createFileAtPath:[self plistPath] contents:nil attributes:nil];
  }
  
  NSMutableArray *dicArray = [NSMutableArray array];
  
  for (JKColor *color in array) {
    
    [dicArray addObject:[color dictionaryFromColor]];
  }
  
  BOOL success = [dicArray writeToFile:[self plistPath] atomically:YES];
  return success;
}

+ (NSString *)plistPath {
  
  return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/color.plist"];
}




+ (NSArray *)getColorArrayFromArchive {
  
  return [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
}

+ (BOOL)saveArrayToArchive:(NSArray *)array {
  
  [NSKeyedArchiver archiveRootObject:array toFile:[self archivePath]];
  
  return YES;
}

+ (NSString *)archivePath {
  
  return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/color.arc"];
}

+ (sqlite3 *)sharedDB {
  
  if (db == nil) {
    
    @synchronized(self)
    {
      
      db = [self openDataBase];
    }
  }
  return db;
}

+(sqlite3*)openDataBase
{
  NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/color.sqlite"];
  if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK)
  {
    NSLog(@"can not open the database:%@",path);
    sqlite3_close(db);
    return nil;
  }
  [self creatTable];
  return db;
}

+ (void)creatTable
{
  char *error;
  char sql[128];
  strcpy(sql, "CREATE TABLE IF NOT EXISTS 'colortable' (id INTEGER PRIMARY KEY, 'name' TEXT, 'r' FLOAT, 'g' FLOAT, 'b' FLOAT)");
  sqlite3_exec(db, sql, nil, nil, &error);
}

+ (NSArray *)getColorArrayFromSqlite {
  
  sqlite3_stmt *stmt = nil;
  NSString *string = [NSString stringWithFormat:@"select * from colortable"];
  char *sql = (char *)[string UTF8String];
  if (sqlite3_prepare_v2([self sharedDB], sql, -1, &stmt, NULL) == !SQLITE_OK) {
    
    NSLog(@"数据库查询失败");
  }
  
  NSMutableArray *array = [NSMutableArray array];
  
  while(sqlite3_step(stmt) ==SQLITE_ROW) {
    
    JKColor* color = [[JKColor alloc]init] ;
    color.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt,1)];
    color.rValue = sqlite3_column_double(stmt, 2);
    color.gValue = sqlite3_column_double(stmt, 3);
    color.bValue = sqlite3_column_double(stmt, 4);
    color.colorID = sqlite3_column_int(stmt, 0);
    [array addObject:color];
  }
  return array;
}

+ (JKColor *)insertToDB:(JKColor *)color {

  NSString *string = [NSString stringWithFormat:@"INSERT INTO 'colortable'(name,r,g,b) VALUES('%@', %f, %f, %f)",color.name,color.rValue,color.gValue,color.bValue];
  char *sql = (char *)[string UTF8String];
  sqlite3_exec([self sharedDB], sql, nil, nil, NULL);
  sqlite3 *db = [self sharedDB];
  
  sqlite3_int64 rowID = sqlite3_last_insert_rowid(db);
  sqlite3_stmt *stmt = nil;
  NSString *queryString = [NSString stringWithFormat:@"select * from 'colortable' where  rowid=%lld",rowID];
  char *querySql = (char *)[queryString UTF8String];
  sqlite3_prepare_v2([self sharedDB], querySql, -1, &stmt, NULL);
  
  while (sqlite3_step(stmt) ==SQLITE_ROW) {
    
    JKColor* color = [[JKColor alloc]init] ;
    color.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt,1)];
    color.rValue = sqlite3_column_double(stmt, 2);
    color.gValue = sqlite3_column_double(stmt, 3);
    color.bValue = sqlite3_column_double(stmt, 4);
    color.colorID = sqlite3_column_int(stmt, 0);
    return color;
  }
  return nil;
}
+ (void)updateToDB:(JKColor *)color {
  
  NSString *string = [NSString stringWithFormat:@"UPDATE 'colortable' SET name='%@', r=%f, g=%f ,b= %f  WHERE id=%d",color.name,color.rValue,color.gValue,color.bValue, color.colorID];
  char *sql = (char *)[string UTF8String];
  
  if (sqlite3_exec([self sharedDB], sql, nil, nil, NULL) != SQLITE_OK) {
    
    NSLog(@"更新失败");
  }
}

+ (void)deleteFromDB:(JKColor *)color {
  
  NSString *string = [NSString stringWithFormat:@"DELETE FROM 'colortable'   WHERE id=%d",color.colorID];
  char *sql = (char *)[string UTF8String];
  
  if (sqlite3_exec([self sharedDB], sql, nil, nil, NULL) != SQLITE_OK) {
    
    NSLog(@"删除失败");
  }
}




@end
