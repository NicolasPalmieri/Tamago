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

/*If the annotation can be represented by a custom static image,
create an instance of the MKAnnotationView class and assign the image to its image property;
see Using the Standard Annotation Views.*/

-(instancetype) initWithPet:(Pet*)pet;
{
    self = [super init];
    if (self)
    {
        _image = pet.imagen;
        _title = pet.name;
        _subtitle = [NSString stringWithFormat:@"LEVEL: %d",[pet showLvl]];
        _coordinate.latitude = pet.latitud;
        _coordinate.longitude = pet.longitud;
    }
    return self;
}


-(MKAnnotationView*) getAnnotationView

{
    MKAnnotationView* view = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MegaAnnotation"];
    view.enabled = YES;
    view.canShowCallout = YES;
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.image]];
    imageView.frame = CGRectMake(0, 0, 50, 50);
    view.leftCalloutAccessoryView = imageView;
    view.image = [UIImage imageNamed:self.image];
    view.bounds = CGRectMake(0, 0, 50, 50);
    return view;
}

@end

