//
//  Anotation.m
//  Tamago
//
//  Created by Nicolas on 12/1/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "Anotation.h"

@interface  Anotation()

@end

@implementation Anotation

#pragma mark - Metodos Anotation
+(void)addAnotation
{
    SpotAnnotation *ann = [[SpotAnnotation alloc] init];
    [ann setCoordinate:[mapParking userLocation].location.coordinate];
    [mapParking addAnnotation:ann];
}

/*If the annotation can be represented by a custom static image,
create an instance of the MKAnnotationView class and assign the image to its image property;
see Using the Standard Annotation Views.*/

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if (![annotation isKindOfClass:[SpotAnnotation class]]) return nil;
    static NSString *dqref = @"MyAnnotation";
    id av = [mapView dequeueReusableAnnotationViewWithIdentifier:dqref]; if (nil == av) {
        av = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:dqref];
        [av setPinColor:MKPinAnnotationColorRed];
        [av setAnimatesDrop:YES];
        [av setCanShowCallout:YES];  //Permitimos que se muestre una vista al hacer tap sobre el pin (por
        //defecto tienen título y subtítulo (fijarse las properties del objeto SpotAnnotation).
    }
    return av;
}

@end

