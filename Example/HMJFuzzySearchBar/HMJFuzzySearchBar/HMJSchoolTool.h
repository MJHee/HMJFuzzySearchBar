//
//  HMJSchoolTool.h
//  HMJFuzzySearchBar
//
//  Created by MJHee on 16/9/5.
//  Copyright © 2016年 MJHee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HMJSchool;

@interface HMJSchoolTool : NSObject
/**
 *  保存一个学校
 */
+ (void)save:(HMJSchool *)school;

/**
 *  查询所有的学校
 */
+ (NSArray *)query;

/**
 *  查询符合要求的学校
 */
+ (NSArray *)queryWithCondition:(NSString *)condition;

/**
 *  删除表
 */
+ (void)deleteTable;

@end
