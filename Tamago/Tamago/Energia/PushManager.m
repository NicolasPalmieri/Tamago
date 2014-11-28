//
//  PushManager.m
//  Tamago
//
//  Created by Nicolas on 11/28/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "PushManager.h"
#import "Pet.h"

@interface  PushManager()

@end

@implementation PushManager

#pragma mark - Metodos Registro
+(void)subscribe_To_Channel
{
    //subscribe channel 'PeleaDeMascotas'
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:@"PeleaDeMascotas" forKey:@"channels"];
    [currentInstallation saveInBackground];
}

+(void)unsubscribe_to_channel
{
    //unsubscribe 'mascotaFight'?
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation removeObject:@"PeleaDeMascotas" forKey:@"channels"];
    [currentInstallation saveInBackground];
}

//visualizar donde estoy subscripto, que canales.
//NSArray *subscribedChannels = [PFInstallation currentInstallation].channels;

#pragma mark - Remote
+(void)sendPush_toEntire_channel
{
    //send a notification to all devices subscribed.
                           
    NSDictionary *data =@{@"code":MSG_COD_PET,
                         @"name":[Pet sharedInstance].name,
                         @"level":[NSNumber numberWithInt:[Pet sharedInstance].showLvl]
                        };
    
    PFPush *push = [[PFPush alloc] init];
    [push setChannels:[NSArray arrayWithObjects:@"PeleaDeMascotas", nil]];
    [push setData:data];
    [push sendPushInBackground];
}

#pragma mark - Local
+(void)sendPush_Local
{
    UILocalNotification *localNotification =[[UILocalNotification alloc]init];
    
    //Detalles
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatCalendar = [NSCalendar currentCalendar];
    localNotification.alertBody = @"Here goes ur 1st advice";
    localNotification.alertAction = @"GET IN";
    localNotification.userInfo = @{@"": @""};
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 7;
    
    // Schedule the notification
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
}

@end
