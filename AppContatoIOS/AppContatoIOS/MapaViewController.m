//
//  MapaViewController.m
//  AppContatoIOS
//
//  Created by macbook on 28/12/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//

#import "MapaViewController.h"
@import MapKit;
@import CoreLocation;

@interface MapaViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation MapaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    
    [_mapa setShowsUserLocation:YES];
    
    MKPointAnnotation*    pino = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D cordenadas;
    cordenadas.latitude=[[self.contato valueForKey:@"latitude"] doubleValue];
    cordenadas.longitude=[[self.contato valueForKey:@"longitude"] doubleValue];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(cordenadas, 1000, 1000);
    [_mapa setRegion:[_mapa regionThatFits:region] animated:YES];
    
    pino.coordinate = cordenadas;
    pino.title = [self.contato valueForKey:@"nome"];
    pino.subtitle = @"Mora aqui!";
    
    [_mapa addAnnotation:pino];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager requestAlwaysAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {

}

@end
