//
//  Pin.h
//  Map
//
//  Created by Martin Kautz on 16.06.15.
//  Copyright (c) 2015 JAKOTA Design Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>


@interface Pin : NSManagedObject <MKAnnotation>

@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lon;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, retain) NSDate * timestamp;

@end
