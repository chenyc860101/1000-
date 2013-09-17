//
//  sharingPage.h
//  TRON
//
//  Created by Wu Ming on 8/19/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"

@interface sharingPage : UIViewController {
	IBOutlet UIWebView *webShare;
	NSMutableArray *addId;
    NSString *urlAddress;
}
@property(nonatomic, retain) UIWebView *webShare;
@property(nonatomic, retain) NSMutableArray *addId;
@end
