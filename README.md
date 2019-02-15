## How to call C/C++ from Swift and Swift from C++

### How to call C from Swift

In **ViewController.swift**:
```swift
hello_c("World".cString(using: String.Encoding.utf8))
```
In **C.h**:
```c
#ifndef C_h
#define C_h
#ifdef __cplusplus
extern "C" {
#endif
    void hello_c(const char * name);
#ifdef __cplusplus
}
#endif
#endif /* C_h */
```
In **C.c**:
```c
#include "C.h"
#include <stdio.h>
void hello_c(const char * name) {
    printf("Hello %s in C\n", name);
}
```
In **Example-Bridging-Header.h**:
```c
#import "C.h"
```

### How to call C++ from Swift (option 1)
In **ViewController.swift**:
```swift
CPP_Wrapper().hello_cpp_wrapped("World")
```
In **CPP.hpp**:
```cpp
#pragma once
#include <string>
class CPP {
public:
    void hello_cpp(const std::string& name);
};
```
In **CPP.cpp**:
```cpp
#include "CPP.hpp"
#include <iostream>
using namespace std;
void CPP::hello_cpp(const std::string& name) {
    cout << "Hello " << name << " in C++" << endl;
}
```
In **CPP-Wrapper.h**:
```objc
#import <Foundation/Foundation.h>
@interface CPP_Wrapper : NSObject
- (void)hello_cpp_wrapped:(NSString *)name;
@end
```
In **CPP-Wrapper.mm**:
```objc
#import "CPP-Wrapper.h"
#include "CPP.hpp"
@implementation CPP_Wrapper
- (void)hello_cpp_wrapped:(NSString *)name {
    CPP cpp;
    cpp.hello_cpp([name cStringUsingEncoding:NSUTF8StringEncoding]);
}
@end
```
In **Example-Bridging-Header.h**:
```c
#import "CPP-Wrapper.h"
```

### How to call C++ from Swift (option 2)

In **ViewController.swift**:
```swift
let queue = LockFreeQueue()
queue.push("1" as NSObject)
queue.push("2" as NSObject)
let first = queue.pop();
print(first as! NSString)
```
In **lock_free_objc_wrapper.h**:
```objc
#import <Foundation/Foundation.h>
#ifndef lock_free_objc_wrapper_h
#define lock_free_objc_wrapper_h
@interface LockFreeQueue : NSObject
- (void)push:(NSObject *)data;
- (NSObject *)pop;
@end
#endif
```
In **lock_free_objc_wrapper.mm**:
```objc
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
```
In **lock_free_queue.hpp**:
```cpp
#ifndef lock_free_queue_hpp
#define lock_free_queue_hpp
#ifdef __cplusplus
template<typename T>
class lock_free_queue {
...
public:
    lock_free_queue() {
    ...
    }
    ~lock_free_queue() {
    ...
    }
    std::unique_ptr<T> pop() {
    ...
    }
    void push(T new_value) {
    ...
    }
#endif
#endif
```
In **Example-Bridging-Header.h**:
```c
#import "lock_free_objc_wrapper.h"
```


### How to call Swift from C++ (plain closure without context)

In **ViewController.swift**:
```swift
let checker = PrimeChecker()
checker.simpleCall {
    print("And back to Swift")
}
```
In **prime_feature_objc_wrapper.h**:
```objc
#import <Foundation/Foundation.h>
#ifndef prime_feature_objc_wrapper_h
#define prime_feature_objc_wrapper_h
@interface PrimeChecker : NSObject
- (void) simpleCall: (void(*)())function;
@end
#endif
```
In **prime_feature_objc_wrapper.mm**:
```objc
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
@end
```
In **prime_checker.hpp**:
```cpp
#ifndef prime_feature_h
#define prime_feature_h
#ifdef __cplusplus
#include <iostream>
#include <string>
class prime_checker {
public:
    void simpleCall(void(*function)()){
      std::cout << "Down to c++" << std::endl;
      function();
    }
};
#endif
#endif
```
