//
//  cash2.h
//  TRON
//
//  Created by Wu Ming on 5/4/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"


@interface cash2 : UIView {
	IBOutlet UITableView *cash2Deal;
	NSMutableArray *cash2Array,*cash2Array2;
}
@property (nonatomic,retain) UITableView *cash2Deal;
@property (nonatomic,retain) NSMutableArray *cash2Array,*cash2Array2;

@end
