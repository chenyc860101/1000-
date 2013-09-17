//
//  mapAnnotation.h
//  TRON
//
//  Created by Wu Ming on 5/8/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface mapAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title, *subtitle, *userinfo;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *userinfo;

@end
