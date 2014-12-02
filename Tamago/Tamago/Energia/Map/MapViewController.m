//
//  MapViewController.m
//  Tamago
//
//  Created by Nicolas on 12/1/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "MapViewController.h"
#import "Anotation.h"
#import "Pet.h"

@interface MapViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end


@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //SETANNOTATION
    Anotation *anotacion = [[Anotation alloc] initWithPet:self.mascota];
    [self.mapView addAnnotation:anotacion];
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    
    //CHANGES
    MKCoordinateRegion region;
    region.center.latitude = self.mascota.latitud;
    region.center.longitude = self.mascota.longitud;
    region.span.latitudeDelta = 0.02;
    region.span.longitudeDelta = 0.02;
    [mapView setRegion:region animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if (![annotation isKindOfClass:[Anotation class]]) return nil;
    static NSString *dqref = @"MegaAnnotation";
    Anotation *myAnot = (Anotation *) annotation;
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:dqref];
  
    if (nil == annotationView)
    {
        annotationView = [myAnot getAnnotationView];        
    }
    else
    {
        annotationView.annotation = annotation;
    }
    return annotationView;
}


@end
