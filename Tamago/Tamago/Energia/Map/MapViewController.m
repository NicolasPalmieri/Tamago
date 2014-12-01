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
}

-(void)viewWillAppear:(BOOL)animated
{
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithLocation:(CLLocation*)cord;
{
    self = [super init];
    if (self)
    {
        self.cordinate = cord;
    }
    return self;
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    //CHANGES
    MKCoordinateRegion region;
    region.center.latitude = [Pet sharedInstance].latitud;
    region.center.longitude = [Pet sharedInstance].longitud;
    region.span.latitudeDelta = 0.02;
    region.span.longitudeDelta = 0.02;
    [mapView setRegion:region animated:YES];
}


@end
