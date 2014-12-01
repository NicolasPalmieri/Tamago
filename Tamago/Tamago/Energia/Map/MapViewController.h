//
//  MapViewController.h
//  Tamago
//
//  Created by Nicolas on 12/1/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Pet.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) CLLocation *cordinate;

- (instancetype)initWithLocation:(CLLocation*)cord;

@end
