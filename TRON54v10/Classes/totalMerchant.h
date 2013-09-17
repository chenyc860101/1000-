//
//  totalMerchant.h
//  TRON
//
//  Created by Wu Ming on 4/19/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"


@interface totalMerchant : UIViewController <UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>{
	IBOutlet UITableView *allView;
	IBOutlet UILabel *load;
	IBOutlet UIActivityIndicatorView *loading;
	NSMutableArray *currentClick,*Allmerchant,*imageInfo,*count,*storeDate2;
	NSDictionary *dealMerchant,*merchantCount,*merchant;
	NSArray *currentDealMerchant;
}
@property (nonatomic,retain) NSMutableArray *currentClick,*Allmerchant,*imageInfo,*count;
@end
