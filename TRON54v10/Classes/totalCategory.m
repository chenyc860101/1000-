    //
//  totalCategory.m
//  TRON
//
//  Created by Wu Ming on 5/7/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "totalCategory.h"


@implementation totalCategory
@synthesize counting,everyCate,logoTotal;

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
    ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=[((category *)((TRONAppDelegate *)APPDELEGATE).categoryWin).cateArray objectAtIndex:(row1*4)+3];
    
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	if ([[counting objectAtIndex:0]intValue]==0) {
		[everyCate removeAllObjects];
		[logoTotal removeAllObjects];
		[storeDate5 removeAllObjects];
		[total reloadData];
		[lo startAnimating];
		[ad setHidden:NO];
		NSInteger row = [[counting objectAtIndex:1]intValue];
		NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((category *)((TRONAppDelegate *)APPDELEGATE).categoryWin).cateArray objectAtIndex:(row*4)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
		NSURL *url = [NSURL URLWithString:fullmessage];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
		[request setDelegate:self];
		[request startAsynchronous];
	}
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
	@try {
		switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
			case 0:
			{
				NSString *totalCat = [request responseString];
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				allTotalCate = [parse objectWithString:totalCat error:nil];
				NSLog(@"TOTAL CATE :%@",allTotalCate);
				NSString *error = [allTotalCate objectForKey:@"error_code"];
				if ([error intValue]==301 || [error intValue]==205) {
					if ([error intValue]==301) {
						UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"No deals found for this category." delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
						[alert show];
						[alert release];
						[lo stopAnimating];
						[ad setHidden:YES];
						//[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).categoryWin]];
					}
					else if ([error intValue]==205)
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
					deal = [allTotalCate objectForKey:@"deals"];
					for (int i=0; i<[deal count]; i++) {
						totalCateData = [deal objectAtIndex:i];
						NSString *data = [totalCateData objectForKey:@"data_url"];
						NSString *end = [totalCateData objectForKey:@"is_expiring_soon"];
						NSString *type = [totalCateData objectForKey:@"deal_type"];
						totalCateMec = [totalCateData objectForKey:@"merchant"];
						NSString *logoThum = [totalCateMec objectForKey:@"logo_thumbnail_url"];
						NSString *logo = [totalCateData objectForKey:@"deal_image_thumbnail_url"];
						NSString *name = [totalCateMec objectForKey:@"name"];
						NSString *titl = [totalCateData objectForKey:@"title"];
						/*NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
						 [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
						 
						 NSString *getDATE = [NSString stringWithFormat:@"%@ +0000",end];
						 NSDate *formatterDate = [inputFormatter dateFromString:getDATE];
						 
						 NSDate *past = [NSDate date];
						 
						 int i = [formatterDate timeIntervalSince1970];
						 int j = [past timeIntervalSince1970];
						 
						 double X = i-j;
						 
						 int totalDays=(int)((double)X/(3600.0*24.00));
						 NSString *realDayLeft = [NSString stringWithFormat:@"%d",totalDays];
						 [storeDate5 addObject:realDayLeft];*/
						[everyCate addObject:data];
						[everyCate addObject:end];
						[everyCate addObject:type];
						[everyCate addObject:logoThum];
						[everyCate addObject:logo];
						[everyCate addObject:name];
						[everyCate addObject:titl];
					}
					for (int i=0; i<[everyCate count]/7; i++) {
						NSString *fullmessage=[NSString stringWithFormat:@"%@",[everyCate objectAtIndex:(i*7)+4]];
						NSURL *url = [NSURL URLWithString:fullmessage];
						ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
						[request startSynchronous];
						[logoTotal addObject:[request responseData]];
					}
					[total reloadData];
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
		NSLog(@"Finally cate");
	}
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	counting = [[NSMutableArray alloc]init];
	everyCate = [[NSMutableArray alloc]init];
	logoTotal = [[NSMutableArray alloc]init];
	[counting addObject:@"0"];
	[counting addObject:@"0"];
	storeDate5 = [[NSMutableArray alloc]init];
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
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:1 withObject:@"9"];
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dealCell"];
	if(cell==nil){
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"dealCell" owner:self options:nil];
		cell = (UITableViewCell *)[nib objectAtIndex:0];
	}
	NSInteger row=[indexPath row];
	[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[logoTotal objectAtIndex:row]]];
	[((UILabel *)[cell viewWithTag:2]) setText:[everyCate objectAtIndex:(row*7)+5]];
	[((UILabel *)[cell viewWithTag:3]) setText:[everyCate objectAtIndex:(row*7)+6]];
    UILabel *label = (UILabel*)[cell viewWithTag:4];
    [label setFrame:CGRectMake(89.0f, 51.0f, 76.0f, 16.0f)];
	if ([[everyCate objectAtIndex:(row*7)+1]intValue]==1) {
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
	return [everyCate count]/7;
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
	[everyCate release];
	[logoTotal release];
	[storeDate5 release];
    [super dealloc];
}


@end
