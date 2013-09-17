//
//  popular.h
//  TRON
//
//  Created by Wu Ming on 5/2/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"


@interface popular : UIViewController <ASIHTTPRequestDelegate>{
	NSMutableArray *popularArray,*popularImage,*recomendArray,*recommendImage,*currCount1,*currCount2,*currentUserType,*storeDate3,*storeDate4;
	IBOutlet UINavigationBar *tit;
	IBOutlet UIToolbar *bar;
	IBOutlet UITableView *tableData;
	IBOutlet UIBarItem *selection;
	IBOutlet UISegmentedControl *optional;
	IBOutlet UIView *barTab;
	IBOutlet UIActivityIndicatorView *lo;
	IBOutlet UILabel *ad;
	int count,count1;
	NSDictionary *recommendPopular,*recoPop,*recoPopMec;
	NSArray *recommendDeal;
}
-(IBAction)segControl:(id)sender;
-(IBAction)recommend:(id)sender;
-(IBAction)refreshPop;
@property (nonatomic,retain) NSMutableArray *popularArray,*popularImage,*recommendArray,*recommendImage,*currCount1,*currCount2,*currentUserType,*storeDate3;
@end
