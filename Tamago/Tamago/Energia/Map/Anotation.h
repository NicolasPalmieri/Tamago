//
//  Anotation.h
//  Tamago
//
//  Created by Nicolas on 12/1/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Anotation : NSObject <MKAnnotation>

@property(assign, nonatomic) CLLocationCoordinate2D cord;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *subtitle;

#pragma mark - Adds
+(void)addAnotation;

@end
