//
//  disCount2.h
//  TRON
//
//  Created by Wu Ming on 5/4/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"


@interface disCount2 : UIView {
	NSMutableArray *discount2Array,*discount2Array2;
	IBOutlet UITableView *discount2Deal;
}
@property (nonatomic,retain) NSMutableArray *discount2Array,*discount2Array2;
@property (nonatomic,retain) UITableView *discount2Deal;

@end
