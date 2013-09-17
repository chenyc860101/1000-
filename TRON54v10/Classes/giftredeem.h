//
//  giftredeem.h
//  TRON
//
//  Created by Wu Ming on 8/22/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"

@interface giftredeem : UIViewController <UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate,UISearchBarDelegate,UIAlertViewDelegate>{
	IBOutlet UISearchBar *searching;
	IBOutlet UITableView *giftTable;
	IBOutlet UIActivityIndicatorView *lo;
	IBOutlet UILabel *ad;
	int count,counting;
	NSDictionary *allGift,*giftData,*searchGift,*final,*merchant;
	NSArray *giftDeal,*searchAnswer;
	NSMutableArray *giftArray,*picGift;
	
}
@property (nonatomic, retain) NSMutableArray *giftArray,*picGift;
@end
