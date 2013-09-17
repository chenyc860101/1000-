//
//  showMap.h
//  TRON
//
//  Created by Wu Ming on 5/23/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"


@interface showMap : UIViewController <CLLocationManagerDelegate,MKReverseGeocoderDelegate,MKMapViewDelegate>{
	IBOutlet MKMapView *mapRes;
	NSMutableArray *selec;
	double latitude,longtitude;
    UIButton *addButton;
}
@property (nonatomic,retain) MKMapView *mapRes;
@property (nonatomic,retain) NSMutableArray *selec;
@end
