/*
 Copyright (c) 2013, Manuel Riess - kokodev.de
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted
 provided that the following conditions are met:
 
 If you happen to meet one of the copyright holders in a bar you are obligated to
 buy them one pint of beer.
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and
 the following disclaimer. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation and/or other materials
 provided with the distribution.
 
 Neither the name of kokodev.de nor the names of its contributors may be used to endorse or promote
 products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
 IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
