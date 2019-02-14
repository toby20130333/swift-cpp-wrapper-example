//
//  prime_feature_objc_wrapper.h
//  Example
//
//  Created by Edward Hyde on 13/02/2019.
//  Copyright © 2019 Edward Hyde. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef prime_feature_objc_wrapper_h
#define prime_feature_objc_wrapper_h

@interface PrimeChecker : NSObject
- (void) simpleCall: (void(*)())function;
- (void) checkIsPrime: (NSString *)value with: (void(*)(void*)) progressCallback andWith: (void(*)(bool result, void* target)) resultCallback withTarget: (void*) target ;
@end


#endif /* prime_feature_objc_wrapper_h */
