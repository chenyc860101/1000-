//
//  account.h
//  TRON
//
//  Created by Wu Ming on 3/31/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"


@interface account : UIViewController <UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate,UIActionSheetDelegate>{
	IBOutlet UISegmentedControl *accInfo;
	IBOutlet UIToolbar *item;
	IBOutlet UIImageView *image;
	IBOutlet UILabel *lab1,*lab2,*lab3,*lab4,*lab5,*lab6,*lab7,*lab8,*lab9,*lab10,*lab11,*lab12,*lab13,*ad;
	NSArray *tools,*prefer;
	NSDictionary *accDetail,*userDetail,*logDetail,*prefreData;
	NSMutableArray *everyDetail,*counting;
	IBOutlet UIActivityIndicatorView *lo;
	IBOutlet UIView *blur;
	IBOutlet UIBarButtonItem *outO;
	IBOutlet UITableView *accTable;
	IBOutlet UITextView *high;
	
}
-(IBAction)control:(id)sender;
-(IBAction)logOut:(id)sender;
-(void)bringsubView;
@property (nonatomic,retain) NSMutableArray *everyDetail,*counting;
@property (nonatomic,retain) UITextView *high;

@end
