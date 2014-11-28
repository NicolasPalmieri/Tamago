//
//  PushManager.h
//  Tamago
//
//  Created by Nicolas on 11/28/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PushManager : NSObject

#pragma Remote Meths
+(void)subscribe_To_Channel;
+(void)unsubscribe_to_channel;
+(void)sendPush_toEntire_channel;

#pragma Local Meths
+(void)sendPush_Local;

@end
