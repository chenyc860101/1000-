//
//  loginMain.h
//  TRON
//
//  Created by Wu Ming on 3/30/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"
#import "ASIFormDataRequest.h"
#import "featured.h"


@interface loginMain : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>{
	UITextField *tUser,*tPass,*myTextField;
	IBOutlet UILabel *load,*testDevice;
	IBOutlet UIActivityIndicatorView *loading;
	IBOutlet UIButton *login,*guest;
	int tag;
	NSArray *button;
	NSMutableArray *userInput,*userFinal,*acc,*userAcc;
	NSDictionary *list,*user;
	NSString *getLa,*getLo;
	UIAlertView *myAlertView;
}
-(IBAction)goMain:(id)sender;
-(IBAction)goMain2:(id)sender;
-(IBAction)goMain3:(id)sender;
-(void)loginLoad:(UIButton *)sender;
-(void)loginLoad2:(id)sender;
@property (nonatomic,retain) UIButton *login,*guest;
@property (nonatomic,retain) NSArray *button;
@property (nonatomic,retain) NSMutableArray *userInput,*userFinal,*acc,*userAcc;

@end
