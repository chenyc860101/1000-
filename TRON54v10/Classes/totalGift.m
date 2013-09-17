    //
//  totalGift.m
//  TRON
//
//  Created by Wu Ming on 8/25/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "totalGift.h"


@implementation totalGift
@synthesize counting,everyGift,logoGift;

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
    NSInteger row1 = [[counting objectAtIndex:1]intValue];
    ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=[((giftredeem *)((TRONAppDelegate *)APPDELEGATE).giftredeemWin).giftArray objectAtIndex:(row1*4)+3];
    
}
-(void)viewWillAppear:(BOOL)animated
{
	if ([[counting objectAtIndex:0]intValue]==0) {
		[everyGift removeAllObjects];
		[logoGift removeAllObjects];
		[totalGiftTable reloadData];
		[lo startAnimating];
		[ad setHidden:NO];
		NSInteger row = [[counting objectAtIndex:1]intValue];
		NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((giftredeem *)((TRONAppDelegate *)APPDELEGATE).giftredeemWin).giftArray objectAtIndex:(row*4)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
		NSURL *url = [NSURL URLWithString:fullmessage];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
		[request setDelegate:self];
		[request startAsynchronous];
	}
	[super viewWillAppear:YES];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
	@try {
		switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
			case 0:
			{
				NSString *totalGif = [request responseString];
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				allTotalGift = [parse objectWithString:totalGif error:nil];
				NSLog(@"TOTAL CATE :%@",allTotalGift);
				NSString *error = [allTotalGift objectForKey:@"error_code"];
				if ([error intValue]==301 || [error intValue]==205) {
					if ([error intValue]==301) {
						//[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).giftredeemWin]];
						UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"No related gift was found for this merchant!" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
						[alert show];
						[alert release];
						[lo stopAnimating];
						[ad setHidden:YES];
					}
					else if ([error intValue]==205 || [error intValue]!=0)
					{
						UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"Please Login again!" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
						[alert show];
						[alert release];
						[lo stopAnimating];
						[ad setHidden:YES];
						[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
					}
				}
				else {
					giftDeal = [allTotalGift objectForKey:@"deals"];
					for (int i=0; i<[giftDeal count]; i++) {
						totalGiftData = [giftDeal objectAtIndex:i];
						NSString *data = [totalGiftData objectForKey:@"data_url"];
						NSString *end = [totalGiftData objectForKey:@"is_expiring_soon"];
						NSString *type = [totalGiftData objectForKey:@"deal_type"];
						totalGiftMec = [totalGiftData objectForKey:@"merchant"];
						NSString *logoThum = [totalGiftMec objectForKey:@"logo_thumbnail_url"];
						NSString *logo = [totalGiftData objectForKey:@"deal_image_thumbnail_url"];
						NSString *name = [totalGiftMec objectForKey:@"name"];
						NSString *titl = [totalGiftData objectForKey:@"title"];
						[everyGift addObject:data];
						[everyGift addObject:end];
						[everyGift addObject:type];
						[everyGift addObject:logoThum];
						[everyGift addObject:logo];
						[everyGift addObject:name];
						[everyGift addObject:titl];
					}
					for (int i=0; i<[everyGift count]/7; i++) {
						NSString *fullmessage=[NSString stringWithFormat:@"%@",[everyGift objectAtIndex:(i*7)+4]];
						NSURL *url = [NSURL URLWithString:fullmessage];
						ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
						[request startSynchronous];
						[logoGift addObject:[request responseData]];
					}
					[totalGiftTable reloadData];
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
		NSLog(@"finally - gift");
	}
	
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	everyGift = [[NSMutableArray alloc]init];
	logoGift = [[NSMutableArray alloc]init];
	counting = [[NSMutableArray alloc]init];
	[counting addObject:@"0"];
	[counting addObject:@"0"];
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",row]];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:1 withObject:@"16"];
	[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).dealWin animated:YES];
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
            ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"";
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).run startAnimating];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).loaded setHidden:NO];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dealCell"];
	if(cell==nil){
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"dealCell" owner:self options:nil];
		cell = (UITableViewCell *)[nib objectAtIndex:0];
	}
	NSInteger row=[indexPath row];
	[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[logoGift objectAtIndex:row]]];
	[((UILabel *)[cell viewWithTag:2]) setText:[everyGift objectAtIndex:(row*7)+5]];
	[((UILabel *)[cell viewWithTag:3]) setText:[everyGift objectAtIndex:(row*7)+6]];
    UILabel *label = (UILabel*)[cell viewWithTag:4];
    [label setFrame:CGRectMake(89.0f, 51.0f, 76.0f, 16.0f)];
	if ([[everyGift objectAtIndex:(row*7)+1]intValue]==1) {
		[((UILabel *)[cell viewWithTag:4]) setHidden:NO];
		[((UIImageView *)[cell viewWithTag:5]) setHidden:NO];
	}
	else {
		[((UILabel *)[cell viewWithTag:4]) setHidden:YES];
		[((UIImageView *)[cell viewWithTag:5]) setHidden:YES];
	}
	
	
	return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[cell setBackgroundColor:indexPath.row%2==0 ? [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] :
	 [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f]];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [everyGift count]/7;
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
	[counting release];
	[everyGift release];
	[logoGift release];
    [super dealloc];
}


@end
