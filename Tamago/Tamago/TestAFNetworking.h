//
//  TestAFNetworking.h
//  Tamago
//
//  Created by Nicolas on 11/26/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface TestAFNetworking : AFHTTPSessionManager

+ (instancetype)sharedInstance;

@end

