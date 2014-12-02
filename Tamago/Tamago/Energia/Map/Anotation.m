//
//  Anotation.m
//  Tamago
//
//  Created by Nicolas on 12/1/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "Anotation.h"

@interface  Anotation()

@property (strong, nonatomic) NSString* auxiliar;

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

#pragma mark - CustomAnnotation
-(MKAnnotationView*) getAnnotationView

{
    MKAnnotationView* view = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MegaAnnotation"];
    view.enabled = YES;
    view.canShowCallout = YES;
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.image]];
    imageView.frame = CGRectMake(0, 0, 40, 40);
    view.leftCalloutAccessoryView = imageView;
    view.image = [UIImage imageNamed:self.image];
    view.bounds = CGRectMake(0, 0, 40, 40);
    
    //Recibo el geocode
    NSString *auxmessage = [self doRevGeocodeUsingLat:self.coordinate.latitude andLng:self.coordinate.longitude];
    
    //Boton de info, reflejado en AlertView.
    if (view && (view.rightCalloutAccessoryView == nil))
    {
        view.canShowCallout = YES;
        UIButton *aux =[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [aux addTarget:self action:@selector(bridgeData) forControlEvents:UIControlEventTouchUpInside];
        view.rightCalloutAccessoryView = aux;
    }
    
    return view;
}

#pragma mark - Geocode
-(NSString*)doRevGeocodeUsingLat:(float)lat andLng:(float)lng
{
    CLLocation *c = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:c
                 completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!error && [placemarks count] > 0)
         {
             NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
             NSLog(@"street address: %@", [dict objectForKey:@"Street"]);
             self.auxiliar = [dict objectForKey:@"Street"];
         }
         else
         {
             NSLog(@"ERROR: %@", error);
         }
     }];
    return self.auxiliar;
}

//puente del selector.
-(void)bridgeData
{
    [self showData:self.auxiliar];
}

//alertview
-(void) showData:(NSString*)auxmessage
{
    UIAlertView *message;
    message = [[UIAlertView alloc] initWithTitle:@"LOCATION!"
                                         message:[NSString stringWithFormat:@"Your gochi is at %@",auxmessage]
                                        delegate:nil
                               cancelButtonTitle:@"ROGERDAT!"
                               otherButtonTitles:nil];
    [message show];
}

@end

