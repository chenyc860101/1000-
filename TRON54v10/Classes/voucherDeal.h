//
//  voucherDeal.h
//  TRON
//
//  Created by Wu Ming on 8/13/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"

@interface voucherDeal : UIViewController {
	IBOutlet UILabel *vouNum,*ownerName,*purchased,*expires;
	IBOutlet UITextView *titleDes,*highLighted;
	IBOutlet UIImageView *logoDeal;
	NSMutableArray *getClick,*storeDate;
	int getID;
}
-(IBAction)getDealDetail;
@property (nonatomic, retain) UITextView *highLighted;
@property (nonatomic, retain) NSMutableArray *getClick,*storeDate;
@end
