//
//  TestAFNetworking.m
//  Tamago
//
//  Created by Nicolas on 11/26/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "NetworkManage.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation NetworkManage

+ (instancetype)sharedInstance
{
    static NetworkManage *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        // Network activity indicator manager setup
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        // Session configuration setup
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024 diskCapacity:50 * 1024 * 1024 // 50MB. on disk cache
                                                              diskPath:nil];
        // 10MB. memory cache
        sessionConfiguration.URLCache = cache;
        sessionConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        sessionConfiguration.timeoutIntervalForRequest = 20;
        // Initialize the session
        _sharedInstance = [[NetworkManage alloc] initWithBaseURL: [NSURL URLWithString:@"http://tamagotchi.herokuapp.com/pet"]sessionConfiguration:sessionConfiguration];
        //Setup a default JSONSerializer for all request/responses.
        _sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer]; });
    return _sharedInstance;
}

@end
