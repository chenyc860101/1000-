//
//  featured.h
//  TRON
//
//  Created by Wu Ming on 3/23/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"
#import "deals.h"
#import "download.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface featured : UIViewController <UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate,CLLocationManagerDelegate,MKAnnotation> {
	IBOutlet UITableView *featureTable;
	NSMutableArray *mechantInfo,*imageData,*dataURL,*dealInfo,*test,*count,*storeDate;
	NSDictionary *allList,*mechant,*dataList,*dataMechant,*deal,*dealMec,*popul,*populMec,*voucher,*voucherDeal1,*viewV,*voucherView,*voucherDeals,*voucherMerchant,*hots,*dealHot,*voucherCodes;
	NSArray *featureMec,*dataMec,*dataMec2,*featureDeal,*popularDeal,*accountDeal,*accountDeal2,*hotDeal,*voucherDealCode;
	IBOutlet UIScrollView *scroll;
	UIButton *button[20];
	IBOutlet UIToolbar *tool1,*tool2;
	IBOutlet UILabel *feature,*dataLoad;
	IBOutlet UIBarButtonItem *show;
	int count1,count2;
	IBOutlet UIActivityIndicatorView *loadData;
	IBOutlet UIImageView *logo1;
	IBOutlet UIToolbar *backGG;
	IBOutlet UISegmentedControl *optional1;
	CLLocationManager *loManager;
	NSString *getLa,*getLo;
	
	NSMutableDictionary *tableImages;
}
-(void)display:(id)sender;
-(IBAction)hide:(id)sender;
-(IBAction)control:(id)sender;
@property (nonatomic,retain) NSMutableArray *dealInfo,*test,*mechantInfo,*count;
@property (nonatomic,retain) NSArray *popularDeal,*hotDeal;
@property (nonatomic,retain) UILabel *dataLoad;
@property (nonatomic,retain) UIActivityIndicatorView *loadData;
@property (nonatomic,retain) UITableView *featureTable;
@end
