//
//  deals.h
//  TRON
//
//  Created by Wu Ming on 3/25/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TRONAppDelegate.h"
#import "loginMain.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h> 


@interface deals : UIViewController <UIWebViewDelegate,ABNewPersonViewControllerDelegate,UIActionSheetDelegate>{
	IBOutlet UIImageView *image,*check,*tagg,*liting,*infinis,*infinis2,*comLogo;
	IBOutlet UIButton *outlet,*buy,*share,*rules,*comSite2,*comTelep,*comFace,*comTwi;
	IBOutlet UILabel *totalBuy,*totalDiscount,*totalValue,*totalSave,*price,*loaded,*loaded2,*nameSave,*username,*mom,*line1,*left,*sellingFast,*messSold,*comName,*rules2;
	NSMutableArray *allDetail,*row,*outletDetail,*dealTyped,*storeUser;
	NSDictionary *totalDeal,*allDeal,*outlets,*dealMechant,*totalShare,*userType;
	NSArray *totalOutlet,*totalUser;
	IBOutlet UIScrollView *scroll;
	IBOutlet UITextView *describe,*highlight,*ground,*ground2,*lcShow;
	IBOutlet UIWebView *highlight2;
	NSInteger num,num2;
	NSString *dealDetail,*fullmessage2,*facebook,*twitter,*comTel,*comSite;
	IBOutlet UIActivityIndicatorView *run,*run2;
	IBOutlet UIView *blur,*paView;
	IBOutlet UISegmentedControl *realInfo;
	NSTimer *timer;
    ABNewPersonViewController *newPersonController;
	int dayLeft,month,X;
}
-(IBAction)tab:(id)sender;
-(IBAction)buy:(id)sender;
-(IBAction)showOutlet:(id)sender;
-(IBAction)sharing:(id)sender;
-(IBAction)merchantClick:(UIButton *)sender;
-(void) updateCountdown;
-(void)solution;
-(void)solution2;
-(void)buttonClick;
- (ABRecordRef)buildContactDetails;
@property (nonatomic,retain) UIImageView *image;
@property (nonatomic,retain) NSMutableArray *allDetail,*row,*outletDetail;
@property (nonatomic,retain) UIActivityIndicatorView *run;
@property (nonatomic,retain) UILabel *totalBuy,*totalDiscount,*totalValue,*totalSave,*price,*name,*loaded,*nameBought,*nameDis,*nameValue,*nameSave,*redeem,*username;
@property (nonatomic,retain) UITextView *ground,*ground2;
@property (nonatomic,retain) UIScrollView *scroll;
@property (nonatomic,retain) UIWebView *highlight2;
@end