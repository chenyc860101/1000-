//
//  preference.h
//  TRON
//
//  Created by Wu Ming on 4/6/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"


@interface preference : UIView <UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>{
	IBOutlet UITableView *check;
	IBOutlet UIButton *save;
	NSArray *detail,*prefer;
	NSMutableArray *checkmark,*getCateData;
	NSDictionary *accDetail,*prefreData;
	int counted;
}
-(IBAction)saveAction;
@property (nonatomic, retain) NSMutableArray *getCateData,*checkmark;
@property (nonatomic, retain) UIButton *save;
@property (nonatomic, retain) UITableView *check;
@end
