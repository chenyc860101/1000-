//
//  totalGift.h
//  TRON
//
//  Created by Wu Ming on 8/25/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"

@interface totalGift : UIViewController <UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>{
	IBOutlet UIActivityIndicatorView *lo;
	IBOutlet UILabel *ad;
	IBOutlet UITableView *totalGiftTable;
	NSDictionary *allTotalGift,*totalGiftData,*totalGiftMec;
	NSArray *giftDeal;
	NSMutableArray *everyGift,*logoGift,*counting;
}
@property (nonatomic,retain) NSMutableArray *counting,*everyGift,*logoGift;
@end
