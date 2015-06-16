# Map


MapKit example of adding POIs interactively. Persistence handled by CD. 


## Environments in which to run Ranglistenpunkte

Ranglistenpunkte runs on iOS 8.3 and above. Took no effort in lowering IPHONE_OS_DEPLOYMENT_TARGET.


## Dependencies

Map depends on [MKMapViewZoom](https://github.com/vhbit/MKMapViewZoom) - an extension based on Troy Brant's implementation.


## Discussion

### What are the important points to take care of, when switching device orientation in this example?
Nothing to worry about, NSLayoutConstraint is here to help. 
However, previously added pins might get off the (visible rect of the) map after changing the device orientation. You could use
```Objective-C
- showAnnotations:animated:
```
to change map's region. From a UX standpoint I would not recommend that as it disregards the user's expectation.


### Within the app lifecycle, what are possible problems which impact the UX of the app?
- Overlapping annotations may prevent the user from picking the right one. 
- Hit area for triggering the callout will prevent the user from being able to add a new POI.

Consider defining tresholds and cluster POIs.


### Consider you have more than 100000 pins on the map, what are potential challenges to watch out for?
- Beside the already mentioned drawbacks above (and given the fact that POIs are actually made from data of a webservice), memory allocation and cpu time will be an issue. Especially if ViewController conforms to the MKMapViewDelegate protocol and implements
```Objective-C
- mapView:viewForAnnotation:
```
with heavy lifting. 
Even actual drawing of - well prepared - objects in this ballpark will take some time and innterfere with user's gestures.

Consider to prepare the POIs in background threads and use two instances of collection classes (current and ongoing) to switch between them as map's annotation array.
Flipping between two maps? Sort of back buffering? 