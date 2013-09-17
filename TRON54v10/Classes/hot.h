//
//  hot.h
//  TRON
//
//  Created by Wu Ming on 8/2/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"

@interface hot : UIViewController {
	NSMutableArray *hotArray,*count,*hotImage;
	IBOutlet UITableView *hotDealTable;
}
@property (nonatomic,retain) UITableView *hotDealTable;
@property (nonatomic,retain) NSMutableArray *hotArray,*count,*hotImage;

@end
