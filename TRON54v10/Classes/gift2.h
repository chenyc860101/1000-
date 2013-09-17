//
//  gift2.h
//  TRON
//
//  Created by Wu Ming on 5/4/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"

@interface gift2 : UIView {
	IBOutlet UITableView *gift2Deal;
	NSMutableArray *gift2Array,*gift2Array2;
}
@property (nonatomic,retain) UITableView *gift2Deal;
@property (nonatomic,retain) NSMutableArray *gift2Array,*gift2Array2;

@end
