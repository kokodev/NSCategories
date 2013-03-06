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
#import "NSNumber+KKDRubyIntExtensions.h"

SPEC_BEGIN(KKDRubyIntExtensionsSpec)

describe(@"The NSNumber", ^{

    it(@"should execute a block n times", ^{
        __block NSNumber *x;
        __block NSInteger counter = 0;
        [@5 times:^(NSNumber *current){
            x = current;
            counter++;
        }];
        [[x should] equal:@4];
        [[theValue(counter) should] equal:@5];
    });

    it(@"should execute a block beginning with its integer value up to n times", ^{
        __block NSNumber *x;
        __block NSInteger counter = 0;
        
        [@1 upto:@10 do:^(NSNumber *current){
            x = current;
            counter++;
        }];
        [[x should] equal:@10];
        [[theValue(counter) should] equal:theValue(10)];
        
        counter = 0;
        [@-10 upto:@10 do:^(NSNumber *current){
            x = current;
            counter++;
        }];
        [[x should] equal:@10];
        [[theValue(counter) should] equal:theValue(21)];
    });

    it(@"should execute a block beginning with its integer value down to n times", ^{
        __block NSNumber *x;
        __block NSInteger counter = 0;
        
        [@10 downto:@5 do:^(NSNumber *current){
            x = current;
            counter++;
        }];
        [[x should] equal:@5];
        [[theValue(counter) should] equal:theValue(6)];

        counter = 0;
        [@10 downto:@-10 do:^(NSNumber *current){
            x = current;
            counter++;
        }];
        [[x should] equal:@-10];
        [[theValue(counter) should] equal:theValue(21)];
    });
    
    it(@"should tell whether it is even", ^{
        [[theValue([@1 even]) should] equal:theValue(NO)];
        [[theValue([@2 even]) should] equal:theValue(YES)];
        [[theValue([@3 even]) should] equal:theValue(NO)];
        [[theValue([@4 even]) should] equal:theValue(YES)];
    });
    
    it(@"should tell whether it is odd", ^{
        [[theValue([@1 odd]) should] equal:theValue(YES)];
        [[theValue([@2 odd]) should] equal:theValue(NO)];
        [[theValue([@3 odd]) should] equal:theValue(YES)];
        [[theValue([@4 odd]) should] equal:theValue(NO)];
    });

    it(@"should provide an NSNumber for the next integer value", ^{
        NSNumber *n1 = @5;
        NSNumber *n2 = [n1 next];
        [[n1 shouldNot] equal:n2];
        [[n2 should] equal:theValue(n1.integerValue + 1)];
        
        [[[@10 next] shouldNot] equal:@9];
        [[[@10 next] shouldNot] equal:@10];
        [[[@10 next] should] equal:@11];
    });

    it(@"should provide an NSNumber for the previous integer value", ^{
        NSNumber *n1 = @5;
        NSNumber *n2 = [n1 pred];
        [[n1 shouldNot] equal:n2];
        [[n2 should] equal:theValue(n1.integerValue - 1)];
        
        [[[@10 pred] shouldNot] equal:@8];
        [[[@10 pred] shouldNot] equal:@11];
        [[[@10 pred] should] equal:@9];
    });

});

SPEC_END
