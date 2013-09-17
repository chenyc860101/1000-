//
//  accountDetail.h
//  TRON
//
//  Created by Wu Ming on 5/9/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"


@interface accountDetail : UIViewController <ASIHTTPRequestDelegate>{
	NSMutableArray *selectedRow,*voucherSuccess,*dealBought,*tempData,*realData,*realLogo,*checkStatus,*displayDate;
	NSDictionary *voucher,*voucherDeal,*viewV,*voucherView,*voucherDeals,*voucherMerchant,*voucherDeal2,*voucherCodes;
	IBOutlet UITableView *cateTable;
	IBOutlet UIActivityIndicatorView *lo;
	IBOutlet UILabel *ad;
	NSArray *accountDeal,*accountDeal2,*accountDeal3,*voucherDealCode;
	NSString *dateString,*dateString2;
    IBOutlet UIView *back;
	int count;
}
-(void)doSomething;
@property (nonatomic,retain) NSMutableArray *selectedRow,*voucherSuccess,*dealBought,*realData,*realLogo,*tempData,*checkStatus,*displayDate;;
@property (nonatomic,retain) UITableView *cateTable;
@end
