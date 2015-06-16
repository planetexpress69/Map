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
#import "Pin.h"

@interface ViewController () <NSFetchedResultsControllerDelegate>
@property (nonatomic, weak) IBOutlet MKMapView *theMapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(addPin:)];
    longPressGestureRecognizer.minimumPressDuration = .3f;
    [_theMapView addGestureRecognizer:longPressGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CLLocationCoordinate2D initialCenterCoordinate = CLLocationCoordinate2DMake(52.5, 13.4);
    [_theMapView setCenterCoordinate:initialCenterCoordinate zoomLevel:10 animated:YES];
    [self cleanSheet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addPin:(id)sender {
    UILongPressGestureRecognizer *longPressGestureRecognizer = (UILongPressGestureRecognizer *)sender;

    if (longPressGestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;

    CGPoint pointInView = [longPressGestureRecognizer locationInView:_theMapView];
    CLLocationCoordinate2D coord = [_theMapView convertPoint:pointInView toCoordinateFromView:_theMapView];
    NSLog(@"lat: %.2f / %.2f", coord.latitude, coord.longitude);

    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    Pin *newPin = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    newPin.timestamp = [NSDate date];
    newPin.title = [newPin.timestamp description];
    newPin.lat = [NSNumber numberWithDouble:coord.latitude];
    newPin.lon = [NSNumber numberWithDouble:coord.longitude];



    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pin" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];

    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];

    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];

    [fetchRequest setSortDescriptors:sortDescriptors];

    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;

    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }


    return _fetchedResultsController;
}


- (void)cleanSheet
{
    NSLog(@"Welcome to the blank sheet!");
    [_theMapView removeAnnotations:_theMapView.annotations];
    [_theMapView addAnnotations:[self.fetchedResultsController fetchedObjects]];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{

    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self fetchDidChangeInsert:anObject];
            break;
        default:
            break;
    }

}

- (void)fetchDidChangeInsert:(Pin *)pin {
    [_theMapView addAnnotation:pin];
}

@end
