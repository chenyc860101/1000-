//
//  MyPlacemark.m
//  TRON
//
//  Created by Chee Ming Chew on 10/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyPlacemark.h"

@implementation MyPlacemark
@synthesize coordinate,title1,subtitle1;

- (NSString *)subtitle{
	return subtitle1;
}
- (NSString *)title{
	return title1;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

@end
