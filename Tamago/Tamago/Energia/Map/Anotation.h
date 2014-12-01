//
//  Anotation.h
//  Tamago
//
//  Created by Nicolas on 12/1/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Pet.h"

@interface Anotation : NSObject <MKAnnotation>

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, readonly, copy) NSString *title;
@property(nonatomic, readonly, copy) NSString *subtitle;
@property(nonatomic, readonly, copy) NSString *image;

-(instancetype) initWithPet:(Pet*)pet;
-(MKAnnotationView*) getAnnotationView;

@end
