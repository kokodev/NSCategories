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

#import "Kiwi.h"
#import "NSDate+KKDExtensions.h"

SPEC_BEGIN(NSDateKKDExtensionsSpec)

describe(@"An NSDate", ^{
    
    __block NSCalendar *calendar;
    
    __block NSNumber *theDay;
    __block NSNumber *theMonth;
    __block NSNumber *theYear;
    __block NSNumber *theWeek;
    __block NSNumber *theStartDay;
    
    beforeAll(^{
        calendar = [NSCalendar currentCalendar];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        theDay = @7;
        theMonth = @3;
        theYear = @2013;
        theWeek = @10;
        theStartDay = (calendar.firstWeekday == 1) ? @3 : @4;
        
        NSDate *currentDate = [formatter dateFromString:@"2013-03-07 10:20:30"];
        
        [NSDate stub:@selector(date) andReturn:currentDate];
    });
    
    afterAll(^{
        [NSDate clearStubs];
    });
    
    it(@"should provide the same value as [NSDate date] when calling [NSDate now]", ^{
        NSDate *date = [NSDate date];
        NSDate *now = [NSDate now];
        [[date should] equal:now];
        
        NSDate *now2 = NSDate.now;
        [[now should] equal:now2];
    });
    
    it(@"should provide a date containing the year, month and day for today", ^{
        NSDate *today = NSDate.today;
        NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                                   fromDate:today];
        
        [[@(components.day) should] equal:theDay];
        [[@(components.month) should] equal:theMonth];
        [[@(components.year) should] equal:theYear];
        
        NSDate *notToday = [NSDate distantFuture];
        components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                 fromDate:notToday];
        
        [[@(components.day) shouldNot] equal:theDay];
        [[@(components.month) shouldNot] equal:theMonth];
        [[@(components.year) shouldNot] equal:theYear];
    });
    
    it(@"should provide a date exactly 1 year before now", ^{
        NSDate *oneYearAgo = [NSDate oneYearAgo];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                                   fromDate:oneYearAgo];
        
        [[@(components.day) should] equal:theDay];
        [[@(components.month) should] equal:theMonth];
        [[@(components.year) should] equal:theValue(theYear.integerValue - 1)];
    });

    it(@"should provide a date exactly 1 year before now", ^{
        NSDate *now = NSDate.now;
        NSDate *oneYearAgo = [now oneYearAgo];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                                   fromDate:oneYearAgo];
        
        [[@(components.day) should] equal:theDay];
        [[@(components.month) should] equal:theMonth];
        [[@(components.year) should] equal:theValue(theYear.integerValue - 1)];
    });

    it(@"should provide a date exactly 1 year ahead of now", ^{
        NSDate *oneYearAhead = [NSDate oneYearAhead];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                                   fromDate:oneYearAhead];
        
        [[@(components.day) should] equal:theDay];
        [[@(components.month) should] equal:theMonth];
        [[@(components.year) should] equal:theValue(theYear.integerValue + 1)];
    });

    it(@"should provide a date exactly 1 year ahead of now", ^{
        NSDate *now = NSDate.now;
        NSDate *oneYearAhead = [now oneYearAhead];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                                   fromDate:oneYearAhead];
        
        [[@(components.day) should] equal:theDay];
        [[@(components.month) should] equal:theMonth];
        [[@(components.year) should] equal:theValue(theYear.integerValue + 1)];
    });

    it(@"should provide the start date of a given week of the current year", ^{
        NSDate *start = [NSDate startOfWeek:10];
        NSDateComponents *components = [calendar components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit | NSWeekOfYearCalendarUnit
                                                   fromDate:start];
        
        [[@(components.day) should] equal:theStartDay];
        [[@(components.month) should] equal:theMonth];
        [[@(components.year) should] equal:theYear];
        [[@(components.weekday) should] equal:@1];
        [[@(components.weekOfYear) should] equal:@10];
    });

    it(@"should provide the start date of a given week of a given year", ^{
        NSDate *start = [NSDate startOfWeek:10 inYear:2012];
        NSDateComponents *components = [calendar components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit | NSWeekOfYearCalendarUnit
                                                   fromDate:start];
        
        // Start of week 10 in 2012 was the 5th of March.
        [[@(components.day) should] equal:((calendar.firstWeekday == 1) ? @4 : @5)];
        [[@(components.month) should] equal:@3];
        [[@(components.year) should] equal:@2012];
        [[@(components.weekday) should] equal:@1];
        [[@(components.weekOfYear) should] equal:@10];
    });

    it(@"should provide the current week of year", ^{
        // Since the date is mocked to a specific date, the result should be the same as in the weekOfYearForDate: test
        NSInteger week = [NSDate currentWeekOfYear];
        [[theValue(week) should] equal:theWeek];
    });

    it(@"should provide the week of year of a given date", ^{
        NSInteger week = [NSDate weekOfYearForDate:NSDate.now];
        [[theValue(week) should] equal:theWeek];
    });

    it(@"should provide the week of year of a given date", ^{
        NSDate *now = NSDate.now;
        NSInteger week = [now weekOfYear];
        [[theValue(week) should] equal:theWeek];
    });

    it(@"should provide the number of weeks within the year of a given date", ^{
        // Date.now is mocked to the year 2013
        NSInteger weeks2013 = [NSDate numberOfWeeksInYearOfDate:NSDate.now];
        [[theValue(weeks2013) should] equal:@52];

        NSDate *oneYearAhead = [NSDate oneYearAhead];
        NSInteger weeks2014 = [NSDate numberOfWeeksInYearOfDate:NSDate.now];
        [[theValue(weeks2014) should] equal:@52];

        NSDate *twoYearsAhead = [oneYearAhead oneYearAhead];
        NSInteger weeks2015 = [NSDate numberOfWeeksInYearOfDate:twoYearsAhead];
        [[theValue(weeks2015) should] equal:@53];
    });

    it(@"should provide the number of weeks within the year of a given date", ^{
        // Date.now is mocked to the year 2013
        NSDate *now = NSDate.now;
        NSInteger weeks2013 = [now numberOfWeeksInYear];
        [[theValue(weeks2013) should] equal:@52];

        NSDate *oneYearAhead = [now oneYearAhead];
        NSInteger weeks2014 = [oneYearAhead numberOfWeeksInYear];
        [[theValue(weeks2014) should] equal:@52];
        
        NSDate *twoYearsAhead = [oneYearAhead oneYearAhead];
        NSInteger weeks2015 = [twoYearsAhead numberOfWeeksInYear];
        [[theValue(weeks2015) should] equal:@53];
    });

    it(@"should provide the number of weeks of the current year", ^{
        // Date.now is mocked to the year 2013
        NSInteger weeks2013 = [NSDate numberOfWeeksThisYear];
        [[theValue(weeks2013) should] equal:@52];
    });
    
});

SPEC_END
