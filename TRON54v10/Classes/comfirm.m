    //
//  comfirm.m
//  TRON
//
//  Created by Wu Ming on 7/25/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "comfirm.h"


@implementation comfirm
@synthesize totalQuantity,totalAmount,highLight;
-(IBAction)finalConfirm
{
	[backWaiting setHidden:NO];
	[lo startAnimating];
	[ad setHidden:NO];
	[self performSelector:@selector(realConfirm) withObject:nil afterDelay:0.2];

}

-(void)realConfirm
{
	[dealBuy removeAllObjects];
	[tempInfo removeAllObjects];
	NSInteger quan = [quantity.text intValue];
	if (quan>0) {
		@try {
			//for (int i=0; i<[quantity.text intValue]; i++) {
			NSString *fullmessage=[NSString stringWithFormat:@"%@",[totalQuantity objectAtIndex:2]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:url];
			[request1 addPostValue:[NSString stringWithFormat:@"%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]] forKey:@"loginKey"];
			[request1 addPostValue:@"bdd2279f-ba2b-4c78-816b-1d438037461b" forKey:@"apiKey"];
			[request1 startSynchronous];				
			NSString *really = [request1 responseString];
			SBJsonParser *parse = [[SBJsonParser alloc]init];
			totalPayed = [parse objectWithString:really error:nil];
			NSLog(@"TOTAL:%@",totalPayed);
			NSString *error = [totalPayed objectForKey:@"error_code"];
            if ([error intValue]==205) {
                NSString *errorMess = [totalPayed objectForKey:@"error_message"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:errorMess delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                [alert show];
                [alert release];
                [((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).currCount2 replaceObjectAtIndex:0 withObject:@"0"];
                [((featured *)((TRONAppDelegate *)APPDELEGATE).featureWin).count replaceObjectAtIndex:0 withObject:@"0"];
                [((featured *)((TRONAppDelegate *)APPDELEGATE).featureWin).featureTable reloadData];
                [((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
                [((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userInput replaceObjectAtIndex:1 withObject:@""];
                [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).checkStatus replaceObjectAtIndex:0 withObject:@"0"];
                [((account *)((TRONAppDelegate *)APPDELEGATE).accWin).counting replaceObjectAtIndex:0 withObject:@"0"];
                [((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
            }
			else if (![error intValue]==0) {
                NSString *errorMess = [totalPayed objectForKey:@"error_message"];
                [getMess replaceObjectAtIndex:1 withObject:errorMess];
                NSString *errorMess2 = [NSString stringWithFormat:@"Sorry there were problems when getting the deal:\n%@",[getMess objectAtIndex:1]];
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TRON Notification"
																message:errorMess2 
															   delegate:self 
													  cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
				[alert show];
				[alert release];
			}
			else {
                NSString *succMess = [totalPayed objectForKey:@"success_message"];
                [getMess replaceObjectAtIndex:0 withObject:succMess];
				voucherJustBrought = [totalPayed objectForKey:@"order"];
				NSString *data = [voucherJustBrought objectForKey:@"data_url"];
				NSLog(@"voucherBrought:%@",voucherJustBrought);
				[dealBuy addObject:data];
			}
			for (int i=0; i<[dealBuy count]; i++) {
				NSString *fullmessage1=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[dealBuy objectAtIndex:i],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
				NSLog(@"FULL:%@",fullmessage);
				NSURL *url1 = [NSURL URLWithString:fullmessage1];
				ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url1];
				[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"mode",nil]];
				[request setDelegate:self];
				[request startAsynchronous];
			}
		}
		@catch (NSException * e) {
			NSLog(@"Exception: %@", e);
		}
		@finally {
			NSLog(@"Finally-download");
		}
	}
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [backWaiting setHidden:YES];
        [lo stopAnimating];
        [ad setHidden:YES];
    }
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
	@try {
		switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
				 case 1:
				 {
				 [tempInfo addObject:[request responseString]];
				 NSLog(@"TEMP COUNT:%d",[tempInfo count]);
				 NSLog(@"dealB:%d",[dealBuy count]);
				 if ([tempInfo count]==[dealBuy count]) {
				 for (int i=0; i<[dealBuy count]; i++) {
				 SBJsonParser *parse = [[SBJsonParser alloc]init];
				 viewVB = [parse objectWithString:[tempInfo objectAtIndex:i] error:nil];
				 NSLog(@"vouVB:%@",viewVB);
				 voucherBoughts = [viewVB objectForKey:@"vouchers"];
				 for (int i=0; i<[voucherBoughts count]; i++) {
				 purchaseView = [voucherBoughts objectAtIndex:i];
				 purchaseDeal = [purchaseView objectForKey:@"deal"];
				 purchaseMerchant = [purchaseDeal objectForKey:@"merchant"];
					 NSString *soon1 = [purchaseView objectForKey:@"is_expiring_soon"];
				 NSString *code = [purchaseView objectForKey:@"voucher_code"];
				 NSString *ved = [purchaseView objectForKey:@"voucher_expire_date"];
				 NSString *iD = [purchaseDeal objectForKey:@"id"];
				 NSString *tit = [purchaseDeal objectForKey:@"title"];
				 NSString *logo2 = [purchaseDeal objectForKey:@"deal_image_thumbnail"];
				 NSString *name1 = [purchaseMerchant objectForKey:@"name"];
                     /*
				 [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:code];
				 [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:ved];
				 [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:iD];
				 [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:tit];
				 [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:logo2];
				 [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:name1];
				 [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:soon1];
				 */
                     [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData insertObject:code atIndex:0];
                     [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData insertObject:ved atIndex:1];
                     [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData insertObject:iD atIndex:2];
                     [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData insertObject:tit atIndex:3];
                     [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData insertObject:logo2 atIndex:4];
                     [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData insertObject:name1 atIndex:5];
                     [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData insertObject:soon1 atIndex:6];
				 NSDate *past = [NSDate date];
				NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
				[dateFormat2 setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
				NSDate *realFormat = [dateFormat2 dateFromString:[NSString stringWithFormat:@"%@",past]];
				[dateFormat2 setDateFormat: @"dd/MM/yyyy"];
				NSString *dateString = [dateFormat2 stringFromDate:realFormat];
					 NSLog(@"realFormat2:%@",realFormat);
				//[((voucherDeal *)((TRONAppDelegate *)APPDELEGATE).voudealWin).storeDate addObject:dateString];
                     [((voucherDeal *)((TRONAppDelegate *)APPDELEGATE).voudealWin).storeDate insertObject:dateString atIndex:0];
                 
				 }
				 }
				 [((TRONAppDelegate *)APPDELEGATE).TABBAR setSelectedItem:[[((TRONAppDelegate *)APPDELEGATE).TABBAR items] objectAtIndex:4]];
				 [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realLogo removeAllObjects];
				 [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).checkStatus replaceObjectAtIndex:0 withObject:@"0"];
				[((TRONAppDelegate *)APPDELEGATE).preferenceVw removeFromSuperview];
				 [((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).accountDetailWin]];
				 [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).cateTable reloadData];
				[((TRONAppDelegate *)APPDELEGATE).preferenceVw removeFromSuperview];
				 ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"My Vouchers";
				NSString *succMess2 = [NSString stringWithFormat:@"Congrats! Your order has been completed!\n%@",[getMess objectAtIndex:0]];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tron Notification"
																	message:succMess2 
																	delegate:self 
														   cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
					 [backWaiting setHidden:YES];
					 [lo stopAnimating];
					 [ad setHidden:YES];
				 }
				 break;
				 }
		}
	}
	@catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"finally-download");
	}
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
-(void)viewDidAppear:(BOOL)animated
{
	((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"Confirm Order";
	[super viewDidAppear:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
	[lo stopAnimating];
	[ad setHidden:YES];
	[backWaiting setHidden:YES];
	NSString *qu = [NSString stringWithFormat:@"%@",[totalQuantity objectAtIndex:0]];
	NSString *des = [NSString stringWithFormat:@"%@",[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).allDetail objectAtIndex:26]];
	[quantity setText:qu];
	[logo setImage:[UIImage imageWithData:[totalQuantity objectAtIndex:3]]];
	[desc setText:des];
	[paymentType setHidden:NO];
	[totalCharges setHidden:NO];
	[titleAmount setText:@"Amount"];
	[totalSub setHidden:NO];
	[lining setHidden:NO];
	[totalText setHidden:NO];
	[colorLine setHidden:NO];
	[totalPrice setHidden:NO];
	[payment setHidden:NO];
	[noteMess2 setHidden:NO];
	[confirmButton setFrame:CGRectMake(107, 263, 96, 32)];
	[highLight setFrame:CGRectMake(6, 19, 308, 283)];
	if ([[totalAmount objectAtIndex:1]isEqual:@"Tron Cash"]) {
		[payment setText:@"Note: This deal will be paid by Tron Cash"];
		[highLight setFrame:CGRectMake(6, 19, 308, 283)];
		[confirmButton setFrame:CGRectMake(93, 253, 133, 32)];
		NSString *subTotal = [NSString stringWithFormat:@"RM%@",[totalAmount objectAtIndex:0]];
		NSString *charges = [NSString stringWithFormat:@"%@",[totalAmount objectAtIndex:2]];
		NSString *price = [NSString stringWithFormat:@"%@",[totalAmount objectAtIndex:4]];
		[totalSub setText:subTotal];
		[totalCharges setText:charges];
		[totalPrice setText:price];
		[noteMess setHidden:YES];
	}
	else if ([[totalAmount objectAtIndex:1]isEqual:@"Tron Talktime"]) {
		[payment setText:@"Note: This deal will be paid by Tron Talktime"];
		[paymentType setHidden:YES];
		[totalCharges setHidden:YES];
		[titleAmount setText:@"Note:"];
		[totalSub setHidden:YES];
		[lining setHidden:YES];
		[totalText setHidden:YES];
		[colorLine setHidden:YES];
		[totalPrice setHidden:YES];
		[payment setHidden:YES];
		[highLight setFrame:CGRectMake(6, 19, 308, 208)];
		[confirmButton setFrame:CGRectMake(93, 177, 133, 32)];
		[noteMess setHidden:NO];
		[noteMess2 setHidden:YES];
	}
	else if ([[totalAmount objectAtIndex:1]isEqual:@"Tron Point"]) {
		[payment setText:@"Note: This deal will be paid by Tron Points"];
		NSString *subTotal = [NSString stringWithFormat:@"%@",[totalAmount objectAtIndex:0]];
		NSString *price = [NSString stringWithFormat:@"%d",[[totalAmount objectAtIndex:5]intValue]];
		[totalSub setText:subTotal];
		[totalCharges setText:price];
		[totalPrice setText:price];
		[noteMess setHidden:YES];
	}
	[super viewWillAppear:YES];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self.highLight.layer setBorderColor:[[UIColor grayColor] CGColor]];
	[self.highLight.layer setCornerRadius:8.0];
	[self.highLight.layer setMasksToBounds:YES];
    self.highLight.clipsToBounds = YES;
	dealBuy = [[NSMutableArray alloc]init];
	tempInfo = [[NSMutableArray alloc]init];
	totalQuantity = [[NSMutableArray alloc]init];
	[totalQuantity addObject:@"0"];
	[totalQuantity addObject:@"0"];
	[totalQuantity addObject:@"0"];
	[totalQuantity addObject:@"0"];
	[totalQuantity addObject:@"0"];
	[totalQuantity addObject:@"0"];
	totalAmount = [[NSMutableArray alloc]init];
	[totalAmount addObject:@"0"];
	[totalAmount addObject:@"0"];
	[totalAmount addObject:@"0"];
	[totalAmount addObject:@"0"];
	[totalAmount addObject:@"0"];
	[totalAmount addObject:@"0"];
    getMess = [[NSMutableArray alloc]init];
    [getMess addObject:@""];
    [getMess addObject:@""];
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[dealBuy release];
	[tempInfo release];
	[totalQuantity release];
	[totalAmount release];
	[highLight release];
    [super dealloc];
}


@end
