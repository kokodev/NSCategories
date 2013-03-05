//
//  NSDate+KKDExtensions.m
//  Weeks
//
//  Created by Manuel Rieß on 01.03.13.
//  Copyright (c) 2013 kokodev.de. All rights reserved.
//

#import "NSDate+KKDExtensions.h"

@implementation NSDate (KKDExtensions)

#pragma mark - Convenience

+ (NSDate *)now
{
    return [NSDate date];
}

+ (NSDate *)today
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *todayComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                                    fromDate:self.now];
    return [calendar dateFromComponents:todayComponents];
}

#pragma mark - Years

+ (NSDate *)oneYearAgo
{
    return [[NSCalendar currentCalendar] dateByAddingComponents:[self componentsWithYearOffset:-1]
                                                         toDate:[NSDate date]
                                                        options:0];
}

+ (NSDate *)oneYearAhead
{
    return [[NSCalendar currentCalendar] dateByAddingComponents:[self componentsWithYearOffset:1]
                                                         toDate:[NSDate date]
                                                        options:0];
}

#pragma mark - Weeks

+ (NSDate *)startOfWeek:(NSInteger)week
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSWeekOfYearCalendarUnit | NSYearForWeekOfYearCalendarUnit
                                               fromDate:[NSDate date]];
    
    [components setWeekOfYear:week];
    [components setWeekday:1];
    
    return [calendar dateFromComponents:components];
}

+ (NSInteger)weekOfYearForDate:(NSDate *)date
{
    NSDateComponents *currentComponents = [[NSCalendar currentCalendar] components:NSWeekOfYearCalendarUnit
                                                                          fromDate:date];
    
    return currentComponents.weekOfYear;
}

+ (NSInteger)currentWeekOfYear
{
    return [self weekOfYearForDate:[NSDate date]];
}

- (NSInteger)weekOfYear
{
    return [self.class weekOfYearForDate:self];
}

#pragma mark - Number of Weeks in Year

+ (NSInteger)numberOfWeeksInYearOfDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSYearCalendarUnit fromDate:date];
    components.month = 3;
    NSDate *tmpDate = [calendar dateFromComponents:components];
    
    calendar.firstWeekday = 2;
    calendar.minimumDaysInFirstWeek = 4;
    
    return [calendar rangeOfUnit:NSWeekOfYearCalendarUnit inUnit:NSYearForWeekOfYearCalendarUnit forDate:tmpDate].length;
}

+ (NSInteger)numberOfWeeksThisYear
{
    return [self numberOfWeeksInYearOfDate:[NSDate date]];
}

- (NSInteger)numberOfWeeksInYear
{
    return [self.class numberOfWeeksInYearOfDate:self];
}

#pragma mark - Private Helper Methods

+ (NSDateComponents *)componentsWithYearOffset:(NSInteger)offset
{
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    offsetComponents.year = offset;
    return offsetComponents;
}

@end
