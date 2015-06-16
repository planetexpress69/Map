//
//  Pin.m
//  Map
//
//  Created by Martin Kautz on 16.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

#import "Pin.h"


@implementation Pin

@dynamic lat;
@dynamic lon;
@dynamic title;
@dynamic timestamp;

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.lat.doubleValue, self.lon.doubleValue);
}

@end
