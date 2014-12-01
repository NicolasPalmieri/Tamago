//
//  Location.m
//  Tamago
//
//  Created by Nicolas on 12/1/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "Location.h"

@interface Location()

@property(strong, nonatomic) CLLocationManager *location;

@end


@implementation Location

+ (void)startUpdates
{
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init]; locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer; // Presición locationManager.distanceFilter = 10; // Distancia mínima de updates [locationManager startUpdatingLocation];
}

#pragma mark - Delegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow]; if (abs(howRecent) < 120.0) // Updates de menos de 2 min.
    {
        [manager stopUpdatingLocation]; // Detener el tracking y utilizar la location theLocation = newLocation;
    }
}

@end
