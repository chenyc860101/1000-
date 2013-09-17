    //
//  accountDetail.m
//  TRON
//
//  Created by Wu Ming on 5/9/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "accountDetail.h"


@implementation accountDetail
@synthesize selectedRow,voucherSuccess,cateTable,dealBought,realData,realLogo,tempData,checkStatus,displayDate;

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
	if ([[selectedRow objectAtIndex:0]intValue]==2) {
		((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"Preferences";

	}
	else {
		((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"My Vouchers";
	}
	[super viewDidAppear:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
	@try {
		[((TRONAppDelegate *)APPDELEGATE).preferenceVw removeFromSuperview];
			if ([[checkStatus objectAtIndex:0]intValue]==0) {
				[cateTable reloadData];
				[displayDate removeAllObjects];
				for (int i=0; i<[realData count]/7; i++) {
					[realLogo addObject:@""];
				}
				for (int i=0; i<[realData count]/7; i++) {
					NSString *fullmessage=[NSString stringWithFormat:@"%@",[realData objectAtIndex:(i*7)+4]];
					NSLog(@"FULLMESSAGE:%@",[realData objectAtIndex:(i*7)+4]);
					NSURL *url = [NSURL URLWithString:fullmessage];
					ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
					[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"img",@"3",@"mode",nil]];
					[request setDelegate:self];
					[request startAsynchronous];
					[checkStatus replaceObjectAtIndex:0 withObject:@"1"];
					NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
					[dateFormat setDateFormat:@"dd/MM/yyyy"];
					NSDate *realFormat = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[realData objectAtIndex:(i*7)+1]]];
					NSDate *realFormat2 = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[((voucherDeal *)((TRONAppDelegate *)APPDELEGATE).voudealWin).storeDate objectAtIndex:[((voucherDeal *)((TRONAppDelegate *)APPDELEGATE).voudealWin).storeDate count]-i-1]]];
					NSLog(@"realFormat2:%@",realFormat);
					[dateFormat setDateFormat: @"MMM d, YYYY"];
					dateString = [dateFormat stringFromDate:realFormat];
					dateString2 = [dateFormat stringFromDate:realFormat2];
					[displayDate addObject:dateString];
					[displayDate addObject:dateString2];
				}
			}
		if ([[selectedRow objectAtIndex:0]intValue]==2) {
			[self.view addSubview:((TRONAppDelegate *)APPDELEGATE).preferenceVw];
		}
		[super viewWillAppear:YES];
			
		}
	@catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"finally-detail");
	}
	
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
	switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
		case 3:
		{
			[realLogo replaceObjectAtIndex:[[[request userInfo] objectForKey:@"img"]intValue] withObject:[request responseData]];
			[cateTable reloadData];
			break;
		}
        case 5:
        {
            NSString *vourcherList = [request responseString];
            SBJsonParser *parse = [[SBJsonParser alloc]init];
            voucher = [parse objectWithString:vourcherList error:nil];
            accountDeal = [voucher objectForKey:@"orders"];
            NSString *error = [voucher objectForKey:@"error_code"];
            NSString *errorMess = [voucher objectForKey:@"error_message"];
            if ([error intValue]==205) {
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
            else {
                NSLog(@"ACCOUNTDEAL :%@",voucher);
                for (int i=0; i<[accountDeal count]; i++) {
                    voucherDeal2 = [accountDeal objectAtIndex:i];
                    NSString *data = [voucherDeal2 objectForKey:@"data_url"];
                    NSString *date = [voucherDeal2 objectForKey:@"purchase_date"];
                    voucherDeals = [voucherDeal2 objectForKey:@"deal"];
                    NSString *iD = [voucherDeals objectForKey:@"id"];
                    NSString *logo = [voucherDeals objectForKey:@"deal_image_thumbnail"];
                    voucherMerchant = [voucherDeals objectForKey:@"merchant"];
                    NSString *name = [voucherMerchant objectForKey:@"name"];
                    NSString *tit = [voucherDeals objectForKey:@"title"];
                    NSString *soon = [voucherDeal2 objectForKey:@"is_expiring_soon"];
                    voucherDealCode = [voucherDeal2 objectForKey:@"vouchers"];
                    for (int j=0; j<[voucherDealCode count]; j++) {
                        voucherCodes = [voucherDealCode objectAtIndex:j];
                        NSString *ved = [voucherCodes objectForKey:@"voucher_expire_date"];
                        NSString *code = [voucherCodes objectForKey:@"voucher_code"];
                        
                        [dealBought addObject:data];
                        [((voucherDeal *)((TRONAppDelegate *)APPDELEGATE).voudealWin).storeDate addObject:date];
                        [realData addObject:code];
                        [realData addObject:ved];
                        [realData addObject:iD];
                        [realData addObject:tit];
                        [realData addObject:logo];
                        [realData addObject:name];
                        [realData addObject:soon];
                    }
                }
                for (int i=0; i<[realData count]/7; i++) {
                    [realLogo addObject:@""];
                }
                for (int i=0; i<[realData count]/7; i++) {
                    NSString *fullmessage=[NSString stringWithFormat:@"%@",[realData objectAtIndex:(i*7)+4]];
                    NSLog(@"FULLMESSAGE:%@",[realData objectAtIndex:(i*7)+4]);
                    NSURL *url = [NSURL URLWithString:fullmessage];
                    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
                    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"img",@"3",@"mode",nil]];
                    [request setDelegate:self];
                    [request startAsynchronous];
                    [checkStatus replaceObjectAtIndex:0 withObject:@"1"];
                    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                    [dateFormat setDateFormat:@"dd/MM/yyyy"];
                    NSDate *realFormat = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[realData objectAtIndex:(i*7)+1]]];
                    NSDate *realFormat2 = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[((voucherDeal *)((TRONAppDelegate *)APPDELEGATE).voudealWin).storeDate objectAtIndex:[((voucherDeal *)((TRONAppDelegate *)APPDELEGATE).voudealWin).storeDate count]-i-1]]];
                    NSLog(@"realFormat2:%@",realFormat);
                    [dateFormat setDateFormat: @"MMM d, YYYY"];
                    dateString = [dateFormat stringFromDate:realFormat];
                    dateString2 = [dateFormat stringFromDate:realFormat2];
                    [displayDate addObject:dateString];
                    [displayDate addObject:dateString2];
                }
                [cateTable reloadData];
                [back setHidden:YES];
                [lo stopAnimating];
                [ad setHidden:YES];
            }
            break;
        }
    }
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	voucherSuccess = [[NSMutableArray alloc]init];
	selectedRow = [[NSMutableArray alloc]init];
	[selectedRow addObject:@""];
	dealBought = [[NSMutableArray alloc]init];
	tempData = [[NSMutableArray alloc]init];
	realData = [[NSMutableArray alloc]init];
	realLogo = [[NSMutableArray alloc]init];
	displayDate = [[NSMutableArray alloc]init];
	count=0;
	checkStatus = [[NSMutableArray alloc]init];
	[checkStatus addObject:@"0"];
	displayDate = [[NSMutableArray alloc]init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]   
                             initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh   
                             target:self   
                             action:@selector(doSomething)];  
    self.navigationItem.rightBarButtonItem = item;  
    [super viewDidLoad];
}
-(void)doSomething
{
    @try {
        NSLog(@"do");
        [back setHidden:NO];
        [lo startAnimating];
        [ad setHidden:NO];
        [realLogo removeAllObjects];
        [displayDate removeAllObjects];
        [dealBought removeAllObjects];
		[tempData removeAllObjects];
		[realData removeAllObjects];
		[displayDate removeAllObjects];
        NSString *fullmessage=[NSString stringWithFormat:@"%@api/voucher/order/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
        NSURL *url = [NSURL URLWithString:fullmessage];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"5",@"mode",nil]];
        [request setDelegate:self];
        [request startAsynchronous];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
    @finally {
        NSLog(@"finally");
    }
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"voucher"];
		if(cell==nil){
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"voucher" owner:self options:nil];
			cell = (UITableViewCell *)[nib objectAtIndex:0];
		}
		NSInteger row = [indexPath row];
    /*
		[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[realLogo objectAtIndex:[realLogo count]-row-1]]];
		[((UILabel *)[cell viewWithTag:2]) setText:[realData objectAtIndex:[realData count]-row-row-row-row-row-row-row-2]];
		[((UILabel *)[cell viewWithTag:3]) setText:[realData objectAtIndex:[realData count]-row-row-row-row-row-row-row-4]];
		[((UILabel *)[cell viewWithTag:4]) setText:[realData objectAtIndex:[realData count]-row-row-row-row-row-row-row-7]];
		[((UILabel *)[cell viewWithTag:7]) setText:[displayDate objectAtIndex:(row*2)]];
		if ([[realData objectAtIndex:[realData count]-row-row-row-row-row-row-row-1]intValue]==1) {
			[((UILabel *)[cell viewWithTag:9]) setHidden:NO];
			[((UIImageView *)[cell viewWithTag:8]) setHidden:NO];
		}
		else {
			[((UILabel *)[cell viewWithTag:9]) setHidden:YES];
			[((UIImageView *)[cell viewWithTag:8]) setHidden:YES];
		}*/
    [((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[realLogo objectAtIndex:row]]];
    [((UILabel *)[cell viewWithTag:2]) setText:[realData objectAtIndex:(row*7)+5]];
    [((UILabel *)[cell viewWithTag:3]) setText:[realData objectAtIndex:(row*7)+3]];
    [((UILabel *)[cell viewWithTag:4]) setText:[realData objectAtIndex:(row*7)]];
    [((UILabel *)[cell viewWithTag:7]) setText:[displayDate objectAtIndex:(row*2)]];
    if ([[realData objectAtIndex:(row*7)+6]intValue]==1) {
        [((UILabel *)[cell viewWithTag:9]) setHidden:NO];
        [((UIImageView *)[cell viewWithTag:8]) setHidden:NO];
    }
    else {
        [((UILabel *)[cell viewWithTag:9]) setHidden:YES];
        [((UIImageView *)[cell viewWithTag:8]) setHidden:YES];
    }

		return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row=[indexPath row];
	[((voucherDeal *)((TRONAppDelegate *)APPDELEGATE).voudealWin).getClick replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",row]];
	[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).voudealWin animated:YES];
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
	[checkStatus replaceObjectAtIndex:0 withObject:@"1"];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//Row for Section
	return [realData count]/7;
}

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
	[displayDate release];
	[realData release];
	[realLogo release];
	[dealBought release];
	[tempData release];
	[voucherSuccess release];
	[selectedRow release];
	[dealBought release];
	[checkStatus release];
	[cateTable release];
    [super dealloc];
}


@end
