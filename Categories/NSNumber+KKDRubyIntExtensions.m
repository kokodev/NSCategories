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

#import "NSNumber+KKDRubyIntExtensions.h"

@implementation NSNumber (KKDRubyExtensions)

- (void)times:(void (^)(NSNumber *))block;
{
    for (int i = 0; i < self.integerValue; i++) {
        block(@(i));
    }
}

- (void)upto:(NSNumber *)limit do:(void (^)(NSNumber *))block
{
    for (int i = self.integerValue; i <= limit.integerValue ; i++) {
        block(@(i));
    }    
}

- (void)downto:(NSNumber *)limit do:(void (^)(NSNumber *))block
{
    for (int i = self.integerValue; i >= limit.integerValue ; i--) {
        block(@(i));
    }
}

- (BOOL)even
{
    if ((self.integerValue % 2) == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)odd
{
    return ![self even];
}

- (NSNumber *)next
{
    return @(self.integerValue + 1);
}

- (NSNumber *)pred
{
    return @(self.integerValue - 1);
}

@end
