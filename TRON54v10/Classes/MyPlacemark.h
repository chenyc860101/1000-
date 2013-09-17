//
//  MyPlacemark.h
//  TRON
//
//  Created by Chee Ming Chew on 10/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <MapKit/MapKit.h>


@interface MyPlacemark : NSObject<MKAnnotation> {
    	CLLocationCoordinate2D coordinate;
    NSString *title1,*subtitle1;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title1;
@property (nonatomic, retain) NSString *subtitle1;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;
- (NSString *)subtitle;
- (NSString *)title;

@end
