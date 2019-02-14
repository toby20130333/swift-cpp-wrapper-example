//
//  prime_feature.m
//  Example
//
//  Created by Edward Hyde on 13/02/2019.
//  Copyright © 2019 Edward Hyde. All rights reserved.
//

#import "prime_feature_objc_wrapper.h"
#include "prime_feature.hpp"
@interface PrimeChecker() {
    prime_checker* checker;
}
@end

@implementation PrimeChecker
- (instancetype)init {
    if (self = [super init]) {
        checker = new prime_checker();
    }
    return self;
}

- (void)dealloc {
    delete checker;
}

- (void)simpleCall: (void(*)())function  {
    checker->simpleCall(function);
}

- (void) checkIsPrime: (NSString *)value with: (void(*)(void*)) progressCallback andWith: (void(*)(bool result, void* target)) resultCallback withTarget: (void*) target{
    checker->checkIsPrime([value UTF8String], progressCallback, resultCallback, target);
}
@end
