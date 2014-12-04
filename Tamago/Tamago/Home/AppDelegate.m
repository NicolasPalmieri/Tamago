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
#import "ViewControllerEnergia.h"
#import "VisitaViewController.h"
#import <Parse/Parse.h>
#import "Pet.h"
#import "Storage.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //BOOL_CAVERNICOLA
    if([[NSUserDefaults standardUserDefaults]boolForKey:BOOL_1ST_VIEW])
    {
        ViewController3* home = [[ViewController3 alloc] initWithNibName:BOOL_1ST_VIEW bundle:nil];
        UINavigationController* navControllerHome = [[UINavigationController alloc] initWithRootViewController:home];
        [self.window setRootViewController:navControllerHome];
        
        if([[NSUserDefaults standardUserDefaults]boolForKey:BOOL_2ND_VIEW])
        {
            ViewControllerEnergia* home = [[ViewControllerEnergia alloc] initWithNibName:BOOL_2ND_VIEW bundle:nil];
            UINavigationController* navControllerHome = [[UINavigationController alloc] initWithRootViewController:home];
            [self.window setRootViewController:navControllerHome];
        }
    }
        else
    {
        ViewController2* home = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:nil];
        UINavigationController* navControllerHome = [[UINavigationController alloc] initWithRootViewController:home];
        [self.window setRootViewController:navControllerHome];
    }
    
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

#pragma mark - Parse Register /SuccessFailure
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

#pragma mark - Parse Remote
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [PFPush handlePush:userInfo];
    
    //RECIBIR USERINFO = DICTIONARy.
    NSString *codeaux = [userInfo objectForKey:@"code"];
    NSString *nameaux = [userInfo objectForKey:@"name"];
    NSString *levelaux = [userInfo objectForKey: @"level"];

    UIAlertView *message;
    message = [[UIAlertView alloc] initWithTitle:@"FOREIGN-LVLUP!"
                                         message:[NSString stringWithFormat:@"%@ GROWUP,%@ upto %@!",codeaux,nameaux,levelaux]
                                        delegate:nil
                               cancelButtonTitle:@"F*CK!"
                               otherButtonTitles:nil];
}

//openURL
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation

{
    NSString *value = [[NSString alloc] init];
    
    NSArray* parameters = [url.absoluteString componentsSeparatedByString:@"//"];
    if([parameters count] != 2)
    {
        return NO; //This does not have parameters but should.
    }
    
    NSString* parametersAsString = [parameters objectAtIndex:1];
    for(NSString* param in [parametersAsString componentsSeparatedByString:@"&"])
    {
        NSArray* keyValue = [param componentsSeparatedByString:@"="];
        NSString* key = [keyValue objectAtIndex:0];
        value = [keyValue objectAtIndex:1];
        NSLog(@"Key: %@ / Value: %@", key, value);
    }
    
    //llamo a la view, code por parametro.
    VisitaViewController *myView = [[VisitaViewController alloc] initWithNibName:@"VisitaViewController" bundle:[NSBundle mainBundle] andCode:value];
    UINavigationController* navControllerHome = [[UINavigationController alloc] initWithRootViewController:myView];
    [self.window setRootViewController:navControllerHome];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [Storage savePet:[Pet sharedInstance]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [Storage savePet:[Pet sharedInstance]];
}



@end
