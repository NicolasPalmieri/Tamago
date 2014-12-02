//
//  LocationManager.m
//  Tamago
//
//  Created by Nicolas on 12/1/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "LocationManager.h"
#import "Pet.h"

@interface LocationManager()

@property (strong, nonatomic) CLLocation *spot;

@end


@implementation LocationManager

- (void)startUpdate
{
    if (nil == self.locationManager)
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // Presición
    self.locationManager.distanceFilter = 5; // Distancia mínima de updates
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [self.locationManager requestWhenInUseAuthorization];
    } else
    {
        [self.locationManager startUpdatingLocation];
    }
    
}

#pragma mark - Delegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    self.spot = locations[0];
    NSDate* eventDate = self.spot.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 120.0) // Updates de menos de 2 min.
    {
        //ASIGNO_CORDS_PET
        [Pet sharedInstance].latitud = self.spot.coordinate.latitude;
        [Pet sharedInstance].longitud = self.spot.coordinate.longitude;
        
        NSLog(@"%f,%f",self.spot.coordinate.latitude,self.spot.coordinate.longitude);
        //[manager stopUpdatingLocation]; // Detener el tracking y utilizar la location theLocation = newLocation;
        
        //DO_POST en caso de moverse..
    }
}


@end
