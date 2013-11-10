#import <CoreLocation/CoreLocation.h>

@class LocationManager;

@protocol LocationManagerProtocol

- (void) locationReceived:(CLLocation *)location;

@end