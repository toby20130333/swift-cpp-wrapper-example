//
//  prime_feature.h
//  Example
//
//  Created by Edward Hyde on 13/02/2019.
//  Copyright © 2019 Edward Hyde. All rights reserved.
//

#ifndef prime_feature_h
#define prime_feature_h
#ifdef __cplusplus

#include <iostream>
#include <future>
#include <chrono>
#include <string>

class prime_checker {
public:
    static bool is_prime (int x) {
        for (int i = 2; i < x; ++i) if (x % i == 0) return false;
        return true;
    }
    
    void checkIsPrime(std::string value, void(*progressCallback)(void*), void(*resultCallback)(bool result, void* target), void* target) {
        std::cout << "In c++ " << value << std::endl;
        std::future<bool> fut = std::async (std::launch::async, is_prime, std::stoi(value));
        std::chrono::milliseconds span (100);
        while (fut.wait_for(span)==std::future_status::timeout)
            progressCallback(target);
        bool x = fut.get();
        resultCallback(x, target);
        std::cout << value << (x ? " is" : " is not") << " prime.\n";
    }
    
    void simpleCall(void(*function)()){
        std::cout << "Down to c++" << std::endl;
        function();
    }
};


#endif /* prime_feature_h */
#endif
