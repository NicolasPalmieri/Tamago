//
//  AppDelegate.m
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController2* home = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:nil];
    UINavigationController* navControllerHome = [[UINavigationController alloc] initWithRootViewController:home];
    
    [self.window setRootViewController:navControllerHome];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Parse
    [Parse setApplicationId:@"guhchukKgURzzZVCHBFOxyD35VHeMQm3EUZEdJvD"
                  clientKey:@"SnnbrQ9yOemJspA7LRt1MCACFFUYNkbQ1k2IM1vH"];
    
    //Register for Push Notitications - Versiones<7 && >8

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil]];
    }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)]; }
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
#endif
    
    //pop
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Parse Register
//Parse meths
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //Store deviceToken 4 Parse
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    //NSLog Success :B
    NSLog(@"Successfully got a push token: %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //NSLog Failure :B
    NSLog(@"Failed to register for push notifications! Error was: %@", [error localizedDescription]);
}

#pragma mark - Parse Local
/*- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif 
{
    NSString *itemName = [notif.userInfo objectForKey:ToDoItemKey];
    // custom method
    [viewController displayItem:itemName];
    app.applicationIconBadgeNumber = notification.applicationIconBadgeNumber - 1;
}*/

#pragma mark - Parse Remote
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}

@end
