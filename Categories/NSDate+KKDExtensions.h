//
//  NSDate+KKDExtensions.h
//  Weeks
//
//  Created by Manuel Rieß on 01.03.13.
//  Copyright (c) 2013 kokodev.de. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (KKDExtensions)

+ (NSDate *)now;
+ (NSDate *)today;

+ (NSDate *)oneYearAgo;
+ (NSDate *)oneYearAhead;

+ (NSDate *)startOfWeek:(NSInteger)week;

+ (NSInteger)weekOfYearForDate:(NSDate *)date;
+ (NSInteger)currentWeekOfYear;
- (NSInteger)weekOfYear;

+ (NSInteger)numberOfWeeksInYearOfDate:(NSDate *)date;
+ (NSInteger)numberOfWeeksThisYear;
- (NSInteger)numberOfWeeksInYear;

@end
