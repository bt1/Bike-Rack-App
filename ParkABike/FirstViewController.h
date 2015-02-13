//
//  FirstViewController.h
//  ParkABike
//
//  Created by Benny Tan on 1/19/15.
//  Copyright (c) 2015 Squarevibe Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Parser.h"
#import "AppDelegate.h"

@interface FirstViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *mapView;


@end


