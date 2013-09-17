//
//  nearBy.h
//  TRON
//
//  Created by Wu Ming on 3/23/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "TRONAppDelegate.h"


@interface nearBy : UIViewController <CLLocationManagerDelegate,MKAnnotation,MKReverseGeocoderDelegate,MKMapViewDelegate,UIAlertViewDelegate,ASIHTTPRequestDelegate> {
	CLLocationManager *loManager;
	IBOutlet MKMapView *mapV;
	IBOutlet UIButton *find;
	IBOutlet UIActivityIndicatorView *lo;
	IBOutlet UILabel *ad;
	IBOutlet UIBarButtonItem *showRef;
	NSMutableArray *allMapData,*mapDetail,*sameCoor,*storeCoor,*testing,*counting,*mapDetail2,*countFinalTotal,*getCurrentLocation,*weird,*counting2,*mapButtonTag;
	NSDictionary *dataMap,*mapMechant,*outlets,*tempMap,*mapMechant2,*nearList,*nearFilter;
	NSArray *mapOutlet,*nearData;
	int count,countCoor,a,countAgain,countTotal,po,b,numTag;
	UIButton *addButton;
	NSString *getLa,*getLo;
	float lat1,longt1;
	mapAnnotation *newAnnotation;
}
-(IBAction)findMe:(id)sender;
-(IBAction)refreshData;
-(void)displayExtraDetail:(UIButton *)sender;
@property (nonatomic,retain) MKMapView *mapV;
@property (nonatomic,retain) NSMutableArray *mapDetail,*counting,*mapDetail2,*getCurrentLocation;
@end
