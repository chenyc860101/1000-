//
//  TRONAppDelegate.h
//  TRON
//
//  Created by Wu Ming on 3/22/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "deals.h"
#import "mapAnnotation.h"
#import "popular.h"
#import "disCount2.h"
#import "cash2.h"
#import "totalCategory.h"
#import "totalNearby.h"
#import "gift2.h"
#import "nearBy.h"
#import "vouchers.h"
#import "loginMain.h"
#import "preference.h"
#import "featured.h"
#import "showAddress.h"
#import "category.h"
#import "showMap.h"
#import "totalMerchant.h"
#import "accountDetail.h"
#import "account.h"
#import "comfirm.h"
#import "hot.h"
#import "voucherDeal.h"
#import "Utilities.h"
#import "sharingPage.h"
#import "setting.h"
#import "giftredeem.h"
#import "totalGift.h"
#import <sys/utsname.h>
#define APPDELEGATE [[UIApplication sharedApplication]delegate]
//#define SERVER @"http://172.16.148.1:8000/"
#define SERVER @"https://mmp.tron.com.my/"
#define DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface TRONAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	IBOutlet UINavigationController *navBar;
	IBOutlet UIView *voucherVw,*preferenceVw,*discountVw,*cashVw,*giftVw,*discount2Vw,*cash2Vw,*gift2Vw;
	IBOutlet UIViewController *featureWin,*nearWin,*dealWin,*downloadWin,*loginWin,*accWin,*totalMerchantView,*popularWin,*categoryWin,*totalCategoryWin,*accountDetailWin,*totalNearbyWin,*showAddressWin,*showMapWin,*comfirmWin,*hotWin,*voudealWin,*sharingPageWin,*settingWin,*giftredeemWin,*totalGiftWin;
	IBOutlet UITabBar *TABBAR;
	NSMutableArray *device;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic,retain) UINavigationController *navBar;
@property (nonatomic,retain) UIViewController *featureWin,*nearWin,*dealWin,*downloadWin,*loginWin,*accWin,*totalMerchantView,*popularWin,*categoryWin,*totalCategoryWin,*accountDetailWin,*totalNearbyWin,*showAddressWin,*showMapWin,*comfirmWin,*hotWin,*voudealWin,*sharingPageWin,*settingWin,*giftredeemWin,*totalGiftWin;
@property (nonatomic,retain) UIView *voucherVw,*settingVw,*preferenceVw,*discountVw,*cashVw,*giftVw,*discount2Vw,*cash2Vw,*gift2Vw;
@property (nonatomic,retain) UITabBar *TABBAR;
@property (nonatomic,retain) NSMutableArray *device;

@end

