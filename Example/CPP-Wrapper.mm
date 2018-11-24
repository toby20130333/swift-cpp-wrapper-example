//
//  CPP-Wrapper.mm
//  Example
//
//  Created by Edward Hyde on 18/11/2018.
//  Copyright © 2018 Edward Hyde. All rights reserved.
//

#import "CPP-Wrapper.h"
#include "CPP.hpp"
@implementation CPP_Wrapper
- (void)hello_cpp_wrapped:(NSString *)name {
    CPP cpp;
    cpp.hello_cpp([name cStringUsingEncoding:NSUTF8StringEncoding]);
}
@end
