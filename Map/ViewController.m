//
//  ViewController.m
//  Map
//
//  Created by Martin Kautz on 16.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MKMapView+ZoomLevel.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet MKMapView *theMapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    CLLocationCoordinate2D initialCenterCoordinate = CLLocationCoordinate2DMake(52.5, 13.4);
    [self.theMapView setCenterCoordinate:initialCenterCoordinate zoomLevel:10 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
