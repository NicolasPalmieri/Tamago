//
//  LocationManager.h
//  Tamago
//
//  Created by Nicolas on 12/1/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <MKMapViewDelegate>

#pragma mark - Manager
@property(strong, nonatomic) CLLocationManager *locationManager;

-(void)startUpdate;

#pragma mark - Adds
//-(void)addAnotation;

@end
