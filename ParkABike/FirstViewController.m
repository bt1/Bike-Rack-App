
//
//  FirstViewController.m
//  ParkABike
//
//  Created by Benny Tan on 1/19/15.
//  Copyright (c) 2015 Squarevibe Inc. All rights reserved.
//

#import "FirstViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [self loadKMLUrl:delegate.url];
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Parsing KML URL

- (void)loadKMLUrl:(NSURL *)url
{
    Parser *parser = [[Parser alloc] initWithContentsOfURL:url];
    parser.rowElementName = @"Placemark";
    parser.elementNames = @[@"name", @"address", @"coordinates", @"description"];
    parser.attributeNames = nil;
    [parser parse];
    
    
    for (NSDictionary *locationDetails in parser.parseItems) {
        NSArray *coordinates = [locationDetails[@"coordinates"] componentsSeparatedByString:@","];
        if (coordinates[1] != nil) {
            CLLocationCoordinate2D rackCoordinate = CLLocationCoordinate2DMake([coordinates[1] doubleValue], [coordinates[0] doubleValue]);
            NSLog(@"%f, %f",rackCoordinate.longitude,rackCoordinate.latitude);
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.title = locationDetails[@"name"];
            NSLog(@"coords=%@", locationDetails[@"coordinates"]);
            annotation.coordinate = rackCoordinate;
            [self.mapView addAnnotation:annotation];
            
        
        }
    }
    
}

#pragma mark - Locating distance between two points

- (double)kilometersFromPlace:(CLLocationCoordinate2D)from andToPlace:(CLLocationCoordinate2D)to
{
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:from.latitude longitude:from.longitude];
    CLLocation *targetLocation = [[CLLocation alloc] initWithLatitude:to.latitude longitude:to.longitude];
    
    CLLocationDistance dist = [userLocation distanceFromLocation:targetLocation]/100;
    NSString *distance = [NSString stringWithFormat:@"%f",dist];
    

    return [distance doubleValue];
    
}


@end
