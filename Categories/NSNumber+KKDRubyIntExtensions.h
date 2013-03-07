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


#import <Foundation/Foundation.h>

// The KKDRubyIntExtensions Category can be used to handle NSNumber objects like int objects
// in Ruby. Only the most commonly used methods are defined yet.

@interface NSNumber (KKDRubyIntExtensions)

// Iterates the given block n times, passing in values from 0 to n - 1.
//
// For example:
// [@5 times:^(NSNumber *current){
//     NSLog("%@", current);
// }];
//
// Produces: "0 1 2 3 4"
//
- (void)times:(void (^)(NSNumber *))block;

// Iterates the given block, passing in integer values from the number up to and including limit.
//
// For example:
// [@5 upto:@10 do:^(NSNumber *current){
//     NSLog("%@", current);
// }];
//
// Produces: "5 6 7 8 9 10"
//
- (void)upto:(NSNumber *)limit do:(void (^)(NSNumber *))block;

// Iterates the given block, passing decreasing values from the number down to and including limit.
//
// For example:
// [@5 downto:@1 do:^(NSNumber *current){
//     NSLog("%@", current);
// }];
//
// Produces: "5 4 3 2 1"
//
- (void)downto:(NSNumber *)limit do:(void (^)(NSNumber *))block;

// Returns true if the number is an even number.
- (BOOL)even;

// Returns true if the number is an odd number.
- (BOOL)odd;

// Returns the number equal to number.integerValue + 1
- (NSNumber *)next;

// Returns the number equal to number.integerValue - 1
- (NSNumber *)pred;

@end
