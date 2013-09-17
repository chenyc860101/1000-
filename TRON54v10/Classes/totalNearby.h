//
//  totalNearby.h
//  TRON
//
//  Created by Wu Ming on 5/19/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"


@interface totalNearby : UIViewController <ASIHTTPRequestDelegate>{
	NSMutableArray *infoNeed,*counting,*nearImage,*getCurrent;
	IBOutlet UIActivityIndicatorView *lo;
	IBOutlet UILabel *ad;
	IBOutlet UITableView *nearTotal;
}
@property(nonatomic,retain) NSMutableArray *infoNeed,*counting,*getCurrent,*nearImage;
@property(nonatomic,retain) UIActivityIndicatorView *lo;
@property(nonatomic,retain) UILabel *ad;
@property(nonatomic,retain) UITableView *nearTotal;
@end
