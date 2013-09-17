//
//  vouchers.h
//  TRON
//
//  Created by Wu Ming on 4/2/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface vouchers : UIView <UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UITableView *voucherTbl;
	NSMutableArray *allVourcher;
	NSDictionary *Vourcher;
}
@property (nonatomic,retain) NSMutableArray *allVourcher;
@property (nonatomic,retain) NSDictionary *Vourcher;
@end
