//
//  comfirm.h
//  TRON
//
//  Created by Wu Ming on 7/25/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"

@interface comfirm : UIViewController <ASIHTTPRequestDelegate,UIAlertViewDelegate>{
	IBOutlet UIImageView *logo;
	IBOutlet UITextView *highLight,*desc;
	IBOutlet UILabel *paymentType,*quantity,*totalPrice,*totalCharges,*payment,*totalSub,*titleAmount,*noteMess,*lining,*totalText,*ad,*noteMess2;
	IBOutlet UIView *colorLine,*backWaiting;
	IBOutlet UIButton *confirmButton;
	IBOutlet UIActivityIndicatorView *lo;
	NSMutableArray *dealBuy,*tempInfo,*totalQuantity,*totalAmount,*getMess;
	NSDictionary *totalPayed,*voucherJustBrought,*viewVB,*purchaseView,*purchaseMerchant,*purchaseDeal;
	NSArray *voucherBoughts;
}
-(IBAction)finalConfirm;
-(void)realConfirm;
@property (nonatomic,retain) NSMutableArray *totalQuantity,*totalAmount;
@property (nonatomic,retain) UITextView *highLight;
@end
