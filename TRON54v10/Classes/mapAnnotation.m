//
//  mapAnnotation.m
//  TRON
//
//  Created by Wu Ming on 5/8/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "mapAnnotation.h"


@implementation mapAnnotation
@synthesize coordinate, title, subtitle, userinfo;

- (id)initWithCoordinate: (CLLocationCoordinate2D) aCoordinate 
{
	if(self = [super init]) coordinate = aCoordinate;
	return self;
}
- (void)dealloc
{
	self.title = nil;
	self.subtitle = nil;
	[super dealloc];
}
@end
