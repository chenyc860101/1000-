//
//  totalCategory.h
//  TRON
//
//  Created by Wu Ming on 5/7/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"


@interface totalCategory : UIViewController <UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>{
	NSMutableArray *counting,*everyCate,*logoTotal,*storeDate5;
	NSDictionary *allTotalCate,*totalCateData,*totalCateMec;
	NSArray *deal;
	IBOutlet UITableView *total;
	IBOutlet UIActivityIndicatorView *lo;
	IBOutlet UILabel *ad;
}
@property (nonatomic,retain) NSMutableArray *counting,*everyCate,*logoTotal;
@end
