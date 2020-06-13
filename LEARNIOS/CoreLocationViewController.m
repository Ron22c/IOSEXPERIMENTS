//
//  CoreLocationViewController.m
//  LEARNIOS
//
//  Created by Ranajit Chandra on 12/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "CoreLocationViewController.h"
#import "NSString+NSStringExtention.h"
#import "protocolViewController.h"
#import "VideoViewController.h"

@interface CoreLocationViewController ()<ProtocolForVC>{
    CLLocationManager *manager;
    UILabel *label;
    UILabel *label2;
    MKMapView *map;
}

@end

@implementation CoreLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSString whatsMyName];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:1.0 green:0.5 blue:0.56 alpha:1]];
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 50)];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 360, self.view.bounds.size.width, 50)];
    [label2 setTextAlignment:NSTextAlignmentCenter];
    
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 420, self.view.bounds.size.width, 100)];
    map.delegate=self;
    map.mapType=MKMapTypeSatellite;
    map.showsUserLocation=YES;
    [self.view addSubview:label];
    [self.view addSubview:label2];
    [self.view addSubview:map];
    
    UIButton *nextVC = [[UIButton alloc] initWithFrame:CGRectMake(0, 600, self.view.bounds.size.width, 100)];
    [nextVC setBackgroundColor:[UIColor blueColor]];
    [nextVC setTitle:@"next VC" forState:UIControlStateNormal];
    [nextVC addTarget:self action:@selector(nextVCAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextVC];
    
    UIButton *avController = [[UIButton alloc] initWithFrame:CGRectMake(0, 800, self.view.bounds.size.width, 100)];
    [avController setTitle:@"video player" forState:UIControlStateNormal];
    [avController setBackgroundColor:[UIColor grayColor]];
    [avController addTarget:self action:@selector(videoVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:avController];
}

- (void)nextVCAction:(UIButton *)sender {
    NSLog(@"pressed nextvc");
    protocolViewController *vc = [[protocolViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:nil];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)videoVC:(UIButton *)sender {
    VideoViewController *view = [[VideoViewController alloc]init];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    manager = [[CLLocationManager alloc] init];
    manager.delegate=self;
    manager.desiredAccuracy=kCLLocationAccuracyKilometer;
    manager.distanceFilter=kCLDistanceFilterNone;
    [manager requestAlwaysAuthorization];
    [manager requestWhenInUseAuthorization];
    [manager startUpdatingLocation];
    
    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:manager.location.coordinate radius:5.0 identifier:@"marker"];
    [manager startMonitoringForRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"fetching loacion");
    if(locations.count>0) {

        NSLog(@"lattitude: %f, longitude: %f", manager.location.coordinate.latitude, manager.location.coordinate.longitude);
        [label setText: [NSString stringWithFormat:@"lattitude: %f, longitude: %f",
                         manager.location.coordinate.latitude, manager.location.coordinate.longitude]];
        NSLog(@"speed: %f, altitude: %f", manager.location.speed, manager.location.altitude);
        [label2 setText: [NSString stringWithFormat:@"speed: %f, altitude: %f",
                          manager.location.speed, manager.location.altitude]];
        
        CLGeocoder *coder = [[CLGeocoder alloc] init];
        [coder reverseGeocodeLocation:manager.location
                    completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
            if(error) {
                NSLog(@"ERROR!! %@",error);
            } else {
                NSLog(@"location: %@", [placemarks objectAtIndex:0].country);
            }
        }];
        
        [manager stopUpdatingLocation];
    } else {
        NSLog(@"Location not found");
    }
}

- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region{
    NSLog(@"entered region");
}

- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region{
    NSLog(@"EXIT from region");
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"started monitoring region");
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 800, 800) animated:YES];
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    point.coordinate=userLocation.location.coordinate;
    point.title=@"my location";
    
    MKCircle *mycircle = [MKCircle circleWithCenterCoordinate:userLocation.location.coordinate radius:800];
    
    [mapView addAnnotation:point];
    [mapView addOverlay:mycircle];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    renderer.fillColor=[UIColor redColor];
    return renderer;
}

- (void)printVCName {
    NSLog(@"Hello");
}

@end
