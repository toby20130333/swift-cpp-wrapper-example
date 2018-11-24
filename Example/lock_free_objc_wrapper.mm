//
//  lock_free_objc_wrapper.m
//  Example
//
//  Created by Edward Hyde on 24/11/2018.
//  Copyright © 2018 Edward Hyde. All rights reserved.
//

#import "lock_free_objc_wrapper.h"
#include "lock_free_queue.hpp"
@interface LockFreeQueue() {
    lock_free_queue<void*>* queue;
}
@end

@implementation LockFreeQueue
- (instancetype)init {
    if (self = [super init]) {
        queue = new lock_free_queue<void*>();
    }
    return self;
}

- (void)dealloc {
    delete queue;
}

- (void)push:(NSObject *)data {
    queue->push((void*)CFBridgingRetain(data));
}

- (NSObject*)pop{
    std::unique_ptr<void*> res = queue->pop();
    if(res == nullptr) return nil;
    return CFBridgingRelease(*res);
}
@end
