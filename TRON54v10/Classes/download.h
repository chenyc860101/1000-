//
//  download.h
//  TRON
//
//  Created by Wu Ming on 3/30/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"

@interface download : UIViewController <ASIHTTPRequestDelegate,UIAlertViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UIImageView *image;
	IBOutlet UITextField *quantity;
	IBOutlet UILabel *name,*price,*totalPrice,*quanO,*paidType,*priceTitle,*totalTitle,*multiPly,*equalTotal,*noteMessage,*noteTitle,*noteMessage2;
	IBOutlet UITextView *descr;
	IBOutlet UIButton *conf;
	NSArray *voucherDeal2,*list;
	NSMutableArray *checkList,*LogoData,*dealTyped,*finalDeci,*paymentType;
	NSIndexPath *old;
	NSDictionary *totalPayed,*checkoutDeal;
	IBOutlet UITextView *highlighted1;
	IBOutlet UITableView *smsChar;
	int count;
}
-(IBAction)confirm:(id)sender;
-(IBAction)textFieldDoneEdit:(id)sender;
@property (nonatomic,retain) UIImageView *image;
@property (nonatomic,retain) NSMutableArray *dealTyped,*LogoData,*checkList;
@property (nonatomic,retain) UITableView *troncash,*smsChar;
@property (nonatomic,retain) UITextView *highlighted1;
@property (nonatomic,retain) UITextField *quantity;
@property int count;

@end
