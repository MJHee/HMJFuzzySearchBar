//
//  HMJSchoolTool.m
//  HMJFuzzySearchBar
//
//  Created by MJHee on 16/9/5.
//  Copyright © 2016年 MJHee. All rights reserved.
//

#import "HMJSchoolTool.h"
#import "HMJSchool.h"
#import "FMDB.h"

@interface HMJSchoolTool ()



@end

@implementation HMJSchoolTool

static FMDatabase *_db;
static FMDatabaseQueue *_dbQueue;

+ (void)initialize {
    //0.获得沙盒路径
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"school.db"];
    NSLog(@"dbPath = %@", dbPath);
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];

    // 1.获得数据库对象
    _db = [FMDatabase databaseWithPath:dbPath];

    // 2.打开数据库
    if ([_db open]) {
        NSLog(@"打开成功");
        // 2.1创建表
        BOOL success = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_school (schoolId text PRIMARY KEY,name text NOT NULL)"];
        if (success) {
            NSLog(@"创建表成功");
        } else{
            NSLog(@"创建表失败");
        }
    } else{
        NSLog(@"打开失败");
    }
}

+ (void)deleteTable {
    //1.拼接SQL语句
    NSString *sql = @"DROP TABLE t_school;";
    NSLog(@"sql = %@", sql);
    //2.执行SQL语句
    [_db executeUpdate:sql];
}

+ (void)save:(HMJSchool *)school {
    NSLog(@"INSERT INTO t_school (schoolId,name) VALUES (%@,%@);", school.schoolId, school.name);
    if ([_db open]) {

        [_dbQueue inDatabase:^(FMDatabase *db) {
             BOOL success = [_db executeUpdate:@"INSERT INTO t_school (schoolId,name) VALUES (?,?);", school.schoolId, school.name];
             if (success) {
                 NSLog(@"插入数据成功!");
             } else{
                 NSLog(@"插入数据失败!");
             }
         }];
    }
}

+ (NSArray *)query {
    return [self queryWithCondition:@""];
}

//模糊查询
+ (NSArray *)queryWithCondition:(NSString *)condition {
    //数组,用来存放所有查询到的学校
    NSMutableArray *schools = [NSMutableArray array];

    if (condition.length > 0) {
        NSLog(@"SELECT schoolId,name FROM t_school WHERE name like '%%%@%%';", condition);

        //1.查询
        NSString *sql    = [NSString stringWithFormat:@"SELECT schoolId,name FROM t_school WHERE name like '%%%@%%';", condition];
        FMResultSet *set = [_db executeQuery:sql];
        //2.取出数据
        while ([set next]) {

            HMJSchool *school = [[HMJSchool alloc] init];
            school.schoolId = [set stringForColumn:@"schoolId"];
            school.name     = [set stringForColumn:@"name"];
            [schools addObject:school];
        };
        [set close];
    } else{
        NSLog(@"SELECT * FROM t_school;");
        //1.查询
        FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_school;"];

        //2.取出数据
        while ([set next]) {

            HMJSchool *school = [[HMJSchool alloc] init];
            school.schoolId = [set stringForColumn:@"schoolId"];
            school.name     = [set stringForColumn:@"name"];
            [schools addObject:school];
        }
        [set close];
    }

    NSLog(@"schools = %@", schools);
    return schools;
}

@end
