    //
//  totalMerchant.m
//  TRON
//
//  Created by Wu Ming on 4/19/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "totalMerchant.h"


@implementation totalMerchant
@synthesize currentClick,Allmerchant,imageInfo,count;

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
-(void)viewWillAppear:(BOOL)animated
{
	if ([[count objectAtIndex:0]intValue] == 0) {
		[Allmerchant removeAllObjects];
		[storeDate2 removeAllObjects];
		[imageInfo removeAllObjects];
		[allView reloadData];
		[loading startAnimating];
		[load setHidden:NO];
		NSInteger num = [[currentClick objectAtIndex:0]intValue];
		NSLog(@"NUM:%@",currentClick);
		NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((featured *)((TRONAppDelegate *)APPDELEGATE).featureWin).mechantInfo objectAtIndex:(num*4)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
		NSURL *url = [NSURL URLWithString:fullmessage];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
		[request setDelegate:self];
		[request startAsynchronous];
	}
	
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
	switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
		case 0:
		{
			NSString *dealDetail = [request responseString];
			SBJsonParser *parse = [[SBJsonParser alloc]init];
			dealMerchant = [parse objectWithString:dealDetail error:nil];
			NSLog(@"DEAL:%@",dealMerchant);
			NSString *error = [dealMerchant objectForKey:@"error_code"];
			if ([error intValue]==301) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TRON Notification" message:@"No deals found for this merchant" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
				[alert show];
				[alert release];
				[loading stopAnimating];
				[load setHidden:YES];
			}
			else {
				currentDealMerchant = [dealMerchant objectForKey:@"deals"];
				for (int i=0; i<[currentDealMerchant count]; i++) {
					merchantCount = [currentDealMerchant objectAtIndex:i];
					NSString *dataurl = [merchantCount objectForKey:@"data_url"];
					NSString *dealExp = [merchantCount objectForKey:@"is_expiring_soon"];
					NSString *end = [merchantCount objectForKey:@"deal_expire_date"];
					merchant = [merchantCount objectForKey:@"merchant"];
					NSString *logoUrl = [merchantCount objectForKey:@"deal_image_thumbnail_url"];
					NSString *name = [merchant objectForKey:@"name"];
					NSString *titleDeal = [merchantCount objectForKey:@"title"];
					NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
					[inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
					
					NSString *getDATE = [NSString stringWithFormat:@"%@ +0000",end];
					NSDate *formatterDate = [inputFormatter dateFromString:getDATE];
					
					NSDate *past = [NSDate date];
					
					int i = [formatterDate timeIntervalSince1970];
					int j = [past timeIntervalSince1970];
					
					double X = i-j;
					
					int totalDays=(int)((double)X/(3600.0*24.00));
					NSString *realDayLeft = [NSString stringWithFormat:@"%d",totalDays];
					[storeDate2 addObject:realDayLeft];
					[Allmerchant addObject:dataurl];
					[Allmerchant addObject:realDayLeft];
					NSLog(@"DATAURL:%@",dataurl);
					[Allmerchant addObject:logoUrl];
					[Allmerchant addObject:name];
					[Allmerchant addObject:titleDeal];
					[Allmerchant addObject:dealExp];
				}
				[super viewWillAppear:YES];
				for (int a=0; a<[Allmerchant count]/6; a++) {
					NSString *fullmessage1=[NSString stringWithFormat:@"%@",[Allmerchant objectAtIndex:(a*6)+2]];
					NSURL *url1 = [NSURL URLWithString:fullmessage1];
					ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:url1];
					[request1 startSynchronous];
					[imageInfo addObject:[request1 responseData]];
				}
				[loading stopAnimating];
				[load setHidden:YES];
				[allView reloadData];
			}
			break;
		}
	}
}
	
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	currentClick = [[NSMutableArray alloc]init];
	[currentClick addObject:@""];
	Allmerchant = [[NSMutableArray alloc]init];
	imageInfo = [[NSMutableArray alloc]init];
	count = [[NSMutableArray alloc]init];
	[count addObject:@"0"];
	storeDate2 = [[NSMutableArray alloc]init];
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Tells that the row is selected
	NSInteger row = [indexPath row];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",row]];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:1 withObject:@"1"];
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
	NSString *name = [NSString stringWithFormat:@"%@",[Allmerchant objectAtIndex:(row*6)+3]];
	NSString *titleName = [NSString stringWithFormat:@"%@",[Allmerchant objectAtIndex:(row*6)+4]];
	[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[imageInfo objectAtIndex:row]]];
	[((UILabel *)[cell viewWithTag:2]) setText:name];
	[((UITextView *)[cell viewWithTag:3]) setText:titleName];
    UILabel *label = (UILabel*)[cell viewWithTag:4];
    [label setFrame:CGRectMake(89.0f, 51.0f, 76.0f, 16.0f)];
	if ([[Allmerchant objectAtIndex:(row*6)+5]intValue]==1) {
		[((UILabel *)[cell viewWithTag:4]) setHidden:NO];
		[((UIImageView *)[cell viewWithTag:5]) setHidden:NO];
	}
	else {
		[((UILabel *)[cell viewWithTag:4]) setHidden:YES];
		[((UIImageView *)[cell viewWithTag:5]) setHidden:YES];
	}
	//Cell for Row
	return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//Row for Section
	return [Allmerchant count]/6;
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
	[currentClick release];
	[Allmerchant release];
	[imageInfo release];
	[count release];
	[storeDate2 release];
    [super dealloc];
}


@end
