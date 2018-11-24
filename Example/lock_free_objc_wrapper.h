//
//  lock_free_objc_wrapper.h
//  Example
//
//  Created by Edward Hyde on 24/11/2018.
//  Copyright © 2018 Edward Hyde. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef lock_free_objc_wrapper_h
#define lock_free_objc_wrapper_h
@interface LockFreeQueue : NSObject
- (void)push:(NSObject *)data;
- (NSObject *)pop;
@end

#endif /* lock_free_objc_wrapper_h */
