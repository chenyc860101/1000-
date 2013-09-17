    //
//  featured.m
//  TRON
//
//  Created by Wu Ming on 3/23/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "featured.h"


@implementation featured
@synthesize dealInfo,test,mechantInfo,dataLoad,loadData,popularDeal,count,featureTable,hotDeal;
-(IBAction)hide:(id)sender
{
	[show setEnabled:NO];
	[optional1 setSelectedSegmentIndex:0];
	for(UIView *subview in [scroll subviews]) {
		if([subview isKindOfClass:[UIButton class]]) {
			[subview removeFromSuperview];
		}
	}
	[((TRONAppDelegate *)APPDELEGATE).discountVw removeFromSuperview];
	count2=0;
	[count replaceObjectAtIndex:0 withObject:@"0"];
	[((account *)((TRONAppDelegate *)APPDELEGATE).accWin).counting replaceObjectAtIndex:0 withObject:@"0"];
	[((totalMerchant *)((TRONAppDelegate *)APPDELEGATE).totalMerchantView).count replaceObjectAtIndex:0 withObject:@"0"];
	[dealInfo removeAllObjects];
	[storeDate removeAllObjects];
	[test removeAllObjects];
	[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).dealBought removeAllObjects];
	[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).tempData removeAllObjects];
	[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData removeAllObjects];
	[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realLogo removeAllObjects];
	[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).storeDate3 removeAllObjects];
	[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray removeAllObjects];
	[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray removeAllObjects];
	[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotImage removeAllObjects];
	[mechantInfo removeAllObjects];
	[loadData startAnimating];
	[dataLoad setHidden:NO];
	[featureTable reloadData];
	NSString *fullmessage=[NSString stringWithFormat:@"%@api/deal/featured/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
	NSURL *url = [NSURL URLWithString:fullmessage];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
	[request setDelegate:self];
	[request startAsynchronous];
}
-(void)display:(id)sender
{
	NSString *click = [NSString stringWithFormat:@"%d",[sender tag]];
	[((totalMerchant *)((TRONAppDelegate *)APPDELEGATE).totalMerchantView).currentClick replaceObjectAtIndex:0 withObject:click];
	[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).totalMerchantView animated:YES];
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
}

-(IBAction)control:(id)sender
{
	switch ([sender selectedSegmentIndex]) {
		case 0:
		{
			[((TRONAppDelegate *)APPDELEGATE).hotWin.view removeFromSuperview];
			break;
		}
		case 1:
		{
			[self.view addSubview:((TRONAppDelegate *)APPDELEGATE).hotWin.view];
			[self.view bringSubviewToFront:scroll];
			[self.view bringSubviewToFront:tool1];
			[self.view bringSubviewToFront:tool2];
			[self.view bringSubviewToFront:feature];
			[self.view bringSubviewToFront:backGG];
			[self.view bringSubviewToFront:logo1];
			break;
		}
		default:
			break;
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
	[super viewDidAppear:YES];
	((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"Back";
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	[((account *)((TRONAppDelegate *)APPDELEGATE).accWin).counting replaceObjectAtIndex:0 withObject:@"0"];
	[((totalMerchant *)((TRONAppDelegate *)APPDELEGATE).totalMerchantView).count replaceObjectAtIndex:0 withObject:@"0"];
	if ([[count objectAtIndex:0]intValue]==0) {
		for(UIView *subview in [scroll subviews]) {
			if([subview isKindOfClass:[UIButton class]]) {
				[subview removeFromSuperview];
			}
		}
		count2=0;
		[dealInfo removeAllObjects];
		[storeDate removeAllObjects];
		[test removeAllObjects];
		[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).dealBought removeAllObjects];
		[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).tempData removeAllObjects];
		[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData removeAllObjects];
		[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realLogo removeAllObjects];
		[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).displayDate removeAllObjects];
		[((voucherDeal *)((TRONAppDelegate *)APPDELEGATE).voudealWin).storeDate removeAllObjects];
		[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).storeDate3 removeAllObjects];
		[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray removeAllObjects];
		[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray removeAllObjects];
		[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotImage removeAllObjects];
		[mechantInfo removeAllObjects];
		[loadData startAnimating];
		[dataLoad setHidden:NO];
		[featureTable reloadData];
		NSLog(@"LogKey%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]);
		NSString *fullmessage=[NSString stringWithFormat:@"%@api/deal/featured/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
		NSURL *url = [NSURL URLWithString:fullmessage];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
		[request setDelegate:self];
		[request startAsynchronous];
	}
	loManager=[[CLLocationManager alloc]init];
	loManager.delegate=self;
	loManager.distanceFilter=kCLDistanceFilterNone;
	loManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
	[loManager startUpdatingLocation];
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:YES animated:YES];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
	@try {
		switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
			case 0:
			{
				
				NSString *featured = [request responseString];
				
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				allList = [parse objectWithString:featured error:nil];
				NSString *error = [allList objectForKey:@"error_code"];
				if ([error intValue]==205 || [error intValue]==100) {
					if ([error intValue]==100) {
						UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"Internal Error!" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
						[alert show];
						[alert release];
						[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
					}
					else {
						UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"Please Login again!" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
						[alert show];
						[alert release];
						[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
					}
					[((TRONAppDelegate *)APPDELEGATE).TABBAR setHidden:YES];
				}
				else {
					NSString *fullmessage=[NSString stringWithFormat:@"%@api/voucher/order/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
					NSURL *url = [NSURL URLWithString:fullmessage];
					ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
					[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"5",@"mode",nil]];
					[request setDelegate:self];
					[request startAsynchronous];
					featureMec = [allList objectForKey:@"featured_merchants"];
					featureDeal = [allList objectForKey:@"featured_deals"];
					popularDeal = [allList objectForKey:@"popular_deals"];
					hotDeal = [allList objectForKey:@"hot_deals"];
					for (int i=0; i<[featureMec count]; i++) {
						mechant = [featureMec objectAtIndex:i];
						NSString *data_url = [mechant objectForKey:@"data_url"];
						NSString *merchantID = [mechant objectForKey:@"id"];
						NSString *image = [mechant objectForKey:@"logo_url"];
						NSString *name = [mechant objectForKey:@"name"];
						[mechantInfo addObject:data_url];
						[mechantInfo addObject:merchantID];
						[mechantInfo addObject:image];
						[mechantInfo addObject:name];
					}
					for (int i=0; i<[featureDeal count]; i++) {
						deal = [featureDeal objectAtIndex:i];
						NSString *data = [deal objectForKey:@"data_url"];
						NSString *end = [deal objectForKey:@"is_selling_fast"];
						NSString *deal_type = [deal objectForKey:@"deal_type"];
						NSString *expire = [deal objectForKey:@"is_expiring_soon"];
						dealMec = [deal objectForKey:@"merchant"];
						NSString *dataUrl = [dealMec objectForKey:@"data_url"];
						NSString *image = [deal objectForKey:@"deal_image_thumbnail_url"];
						NSString *name = [dealMec objectForKey:@"name"];
						NSString *tit = [deal objectForKey:@"title"];
						[dealInfo addObject:data];
						[dealInfo addObject:end];
						[dealInfo addObject:deal_type];
						[dealInfo addObject:@"test"];
						[dealInfo addObject:dataUrl];
						[dealInfo addObject:image];
						[dealInfo addObject:name];
						[dealInfo addObject:tit];
						[dealInfo addObject:expire];
					}
					for (int i=0; i<[hotDeal count]; i++) {
						hots = [hotDeal objectAtIndex:i];
						NSString *data = [hots objectForKey:@"data_url"];
						NSString *end = [hots objectForKey:@"is_selling_fast"];
						NSString *deal_type = [hots objectForKey:@"deal_type"];
						NSString *expire = [hots objectForKey:@"is_expiring_soon"];
						dealHot = [hots objectForKey:@"merchant"];
						NSString *dataUrl = [dealHot objectForKey:@"data_url"];
						NSString *image = [hots objectForKey:@"deal_image_thumbnail_url"];
						NSString *name = [dealHot objectForKey:@"name"];
						NSString *tit = [hots objectForKey:@"title"];
						[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray addObject:data];
						[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray addObject:end];
						[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray addObject:deal_type];
						[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray addObject:expire];
						[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray addObject:dataUrl];
						[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray addObject:image];
						[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray addObject:name];
						[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray addObject:tit];

					}
					
					for (int i=0; i<[mechantInfo count]/4; i++) {
						NSString *fullmessage=[NSString stringWithFormat:@"%@",[mechantInfo objectAtIndex:(i*4)+2]];
						NSString *dataMessage=[NSString stringWithFormat:@"%@",[mechantInfo objectAtIndex:(i*4)]];
						
						button[i] = [UIButton buttonWithType:UIButtonTypeCustom];
						button[i].frame=CGRectMake(90*i+7, 8, 80, 80);
						button[i].tag=i;
						[button[i] setBackgroundColor:[UIColor whiteColor]];
						
						[scroll addSubview:button[i]];
						[button[i] addTarget:self action:@selector(display:) forControlEvents:UIControlEventTouchUpInside];
						[scroll setContentSize:CGSizeMake(90*(i+1)+7, 80)];
						NSURL *url = [NSURL URLWithString:fullmessage];
						ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
						[request setDelegate:self];
						[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"img",@"1",@"mode",nil]];
						[request startAsynchronous];
						
						NSURL *urlData = [NSURL URLWithString:dataMessage];
						request = [ASIHTTPRequest requestWithURL:urlData];
						[request setDelegate:self];
						[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"mode",nil]];
						[request startAsynchronous];
						
					}
					if ([[count objectAtIndex:0]intValue]==0) {
						for (int i=0; i<[dealInfo count]/9; i++) {
							[test addObject:@""];
						}
						for (int i=0; i<[dealInfo count]/9; i++) {
							NSString *fullmessage=[NSString stringWithFormat:@"%@",[dealInfo objectAtIndex:(i*9)+5]];
							NSURL *url = [NSURL URLWithString:fullmessage];
							ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
							[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"image",@"4",@"mode",nil]];
							[request setDelegate:self];
							[request startAsynchronous];
						}
						for (int i=0; i<[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray count]/8; i++) {
							[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotImage addObject:@""];
						}
						for (int i=0; i<[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray count]/8; i++) {
							NSString *fullmessage=[NSString stringWithFormat:@"%@",[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray objectAtIndex:(i*8)+5]];
							NSURL *url = [NSURL URLWithString:fullmessage];
							ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
							[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"img",@"7",@"mode",nil]];
							[request setDelegate:self];
							[request startAsynchronous];
						}
					}
					for (int i=0; i<[popularDeal count]; i++) {
						popul = [popularDeal objectAtIndex:i];
						NSString *data = [popul objectForKey:@"data_url"];
						NSString *end = [popul objectForKey:@"is_selling_fast"];
						NSString *type = [popul objectForKey:@"deal_type"];
						NSString *hits = [popul objectForKey:@"is_expiring_soon"];
						populMec = [popul objectForKey:@"merchant"];
						NSString *data2 = [populMec objectForKey:@"data_url"];
						NSString *logo = [popul objectForKey:@"deal_image_thumbnail_url"];
						NSString *name = [populMec objectForKey:@"name"];
						NSString *tit = [popul objectForKey:@"title"];
						[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray addObject:data];
						[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray addObject:end];
						[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray addObject:type];
						[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray addObject:hits];
						[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray addObject:@"test"];
						[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray addObject:data2];
						[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray addObject:logo];
						[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray addObject:name];
						[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray addObject:tit];
						
					}
				}
				[featureTable reloadData];
				[count replaceObjectAtIndex:0 withObject:@"1"];
			}
				break;
			case 1:
			{
				[button[[[[request userInfo] objectForKey:@"img"] intValue]] setBackgroundImage:[UIImage imageWithData:[request responseData]] forState:UIControlStateNormal];
				break;
			}
			case 4:
			{
				[test replaceObjectAtIndex:[[[request userInfo]objectForKey:@"image"]intValue] withObject:[request responseData]];
				break;
			}
			case 5:
			{
				NSString *vourcherList = [request responseString];
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				voucher = [parse objectWithString:vourcherList error:nil];
				accountDeal = [voucher objectForKey:@"orders"];
            if ([accountDeal count]==0) {
                [show setEnabled:YES];
            }
            NSLog(@"My Vouncher:%@",accountDeal);
				for (int i=0; i<[accountDeal count]; i++) {
					voucherDeal1 = [accountDeal objectAtIndex:i];
					NSString *data = [voucherDeal1 objectForKey:@"data_url"];
					NSString *date = [voucherDeal1 objectForKey:@"purchase_date"];
                    voucherDeals = [voucherDeal1 objectForKey:@"deal"];
                    NSString *iD = [voucherDeals objectForKey:@"id"];
                    NSString *logo = [voucherDeals objectForKey:@"deal_image_thumbnail"];
                    voucherMerchant = [voucherDeals objectForKey:@"merchant"];
                    NSString *name = [voucherMerchant objectForKey:@"name"];
                    NSString *tit = [voucherDeals objectForKey:@"title"];
                    NSString *soon = [voucherDeal1 objectForKey:@"is_expiring_soon"];
                    voucherDealCode = [voucherDeal1 objectForKey:@"vouchers"];
                    for (int j=0; j<[voucherDealCode count]; j++) {
                        voucherCodes = [voucherDealCode objectAtIndex:j];
                        NSString *ved = [voucherCodes objectForKey:@"voucher_expire_date"];
                        NSString *code = [voucherCodes objectForKey:@"voucher_code"];
                        
                        [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).dealBought addObject:data];
                        [((voucherDeal *)((TRONAppDelegate *)APPDELEGATE).voudealWin).storeDate addObject:date];
                        [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:code];
                        [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:ved];
                        [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:iD];
                        [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:tit];
                        [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:logo];
                        [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:name];
                        [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:soon];
                    }                    
				}
                [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).cateTable reloadData];
				/*for (int i=0; i<[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).dealBought count]; i++) {
					NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).dealBought objectAtIndex:i],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
					NSURL *url = [NSURL URLWithString:fullmessage];
					ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
					[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"6",@"mode",nil]];
					[request setDelegate:self];
					[request startAsynchronous];
				}*/
				break;
			}
			/*case 6:
			{
				[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).tempData addObject:[request responseString]];
                 NSLog(@"vou:%@",[request responseString]);
				if ([((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).tempData count]==[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).dealBought count]) {
					for (int i=0; i<[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).tempData count]; i++) {
						SBJsonParser *parse = [[SBJsonParser alloc]init];
						viewV = [parse objectWithString:[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).tempData objectAtIndex:i] error:nil];
						accountDeal2 = [viewV objectForKey:@"vouchers"];
						for (int i=0; i<[accountDeal2 count]; i++) {
							if (i==[accountDeal2 count]-1) {
								[show setEnabled:YES];
							}
							voucherView = [accountDeal2 objectAtIndex:i];
							voucherDeals = [voucherView objectForKey:@"deal"];
							voucherMerchant = [voucherDeals objectForKey:@"merchant"];
							NSString *soon = [voucherView objectForKey:@"is_expiring_soon"];
							NSString *code = [voucherView objectForKey:@"voucher_code"];
							NSString *ved = [voucherView objectForKey:@"voucher_expire_date"];
							NSString *iD = [voucherDeals objectForKey:@"id"];
							NSString *tit = [voucherDeals objectForKey:@"title"];
							NSString *logo = [voucherDeals objectForKey:@"deal_image_thumbnail"];
							NSString *name = [voucherMerchant objectForKey:@"name"];
							[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:code];
							[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:ved];
							[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:iD];
							[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:tit];
							[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:logo];
							[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:name];
							[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData addObject:soon];
						}
					}
					[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).cateTable reloadData];
				}
				break;
			}*/
			case 7:
			{
				[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotImage replaceObjectAtIndex:[[[request userInfo]objectForKey:@"img"]intValue] withObject:[request responseData]];
				break;
			}
		}
		[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotDealTable reloadData];
		[featureTable reloadData];
		[loadData stopAnimating];
		[dataLoad setHidden:YES];
	}
	@catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"fianlly");
	}
	
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
	switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
			case 4:
			NSLog(@"...");
			break;

	}
	if (count2==0) {
		UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Internet Connection" message:@"It appears that you might not have an internet connection. Please make sure your 3G/WIFI is switched on." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
		count2=1;
	}
	[loadData stopAnimating];
	[dataLoad setHidden:YES];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    if ([newLocation.timestamp timeIntervalSince1970] < [NSDate timeIntervalSinceReferenceDate] - 60)
        return;
    
	getLa = [NSString stringWithFormat:@"%g",fabs(newLocation.coordinate.latitude)];
	getLo = [NSString stringWithFormat:@"%g",fabs(newLocation.coordinate.longitude)];
	[((nearBy *)((TRONAppDelegate *)APPDELEGATE).nearWin).getCurrentLocation replaceObjectAtIndex:0 withObject:getLa];
	[((nearBy *)((TRONAppDelegate *)APPDELEGATE).nearWin).getCurrentLocation replaceObjectAtIndex:1 withObject:getLo];
	
	manager.delegate = nil;
    [manager stopUpdatingLocation];
    [manager autorelease];
	
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	count = [[NSMutableArray alloc]init];
	[count addObject:@"0"];
	count1=0;
	count2=0;
	scroll.delegate = self;
	test=[[NSMutableArray alloc]init];
	mechantInfo=[[NSMutableArray alloc]init];
	dealInfo = [[NSMutableArray alloc]init];
	dataURL = [[NSMutableArray alloc]init];
	storeDate = [[NSMutableArray alloc]init];
	//Load Featured 
	
	[super viewDidLoad];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Tells that the row is selected
	NSInteger row=[indexPath row];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",row]];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:1 withObject:@"0"];
	[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).dealWin animated:YES];
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
     ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"";
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).run startAnimating];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).loaded setHidden:NO];
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style: UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] autorelease];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[cell setBackgroundColor:indexPath.row%2==0 ? [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] :
	 [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dealCell"];
	if(cell==nil){
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"dealCell" owner:self options:nil];
		cell = (UITableViewCell *)[nib objectAtIndex:0];
	}
	NSInteger row=[indexPath row];
	if([test count]>row)
	[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[test objectAtIndex:row]]];
	
	[((UILabel *)[cell viewWithTag:2]) setText:[dealInfo objectAtIndex:(row*9)+6]];
	[((UITextView *)[cell viewWithTag:3]) setText:[dealInfo objectAtIndex:(row*9)+7]];
    UILabel *label = (UILabel*)[cell viewWithTag:4];
            [label setFrame:CGRectMake(89.0f, 51.0f, 76.0f, 16.0f)];
	if ([[dealInfo objectAtIndex:(row*9)+1]intValue]==1) {
		[((UILabel *)[cell viewWithTag:4]) setHidden:YES]; 
		[((UIImageView *)[cell viewWithTag:5]) setHidden:NO];
		[((UILabel *)[cell viewWithTag:6]) setHidden:NO];
	}
	else if ([[dealInfo objectAtIndex:(row*9)+8]intValue]==1) {
        [((UIImageView *)[cell viewWithTag:5]) setHidden:NO];
		[((UILabel *)[cell viewWithTag:4]) setHidden:NO];
		[((UILabel *)[cell viewWithTag:6]) setHidden:YES];
	}
	else {
		[((UILabel *)[cell viewWithTag:4]) setHidden:YES];
		[((UIImageView *)[cell viewWithTag:5]) setHidden:YES];
		[((UILabel *)[cell viewWithTag:6]) setHidden:YES];
	}
	//Cell for Row
	return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//Row for Section
	return [dealInfo count]/9;
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
	[count release];
	[test release];
	[mechantInfo release];
	[dealInfo release];
	[dataURL release];
	[storeDate release];
	[dataLoad release];
	[loadData release];
	[popularDeal release];
	[hotDeal release];
	[featureTable release];
    [super dealloc];
}
@end
