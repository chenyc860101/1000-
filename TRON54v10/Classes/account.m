    //
//  account.m
//  TRON
//
//  Created by Wu Ming on 3/31/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "account.h"


@implementation account
@synthesize everyDetail,counting,high;

-(IBAction)logOut:(id)sender
{
	if ([[counting objectAtIndex:0]intValue]==1) {
		UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"Do you want to log out?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
		[action showFromTabBar:((TRONAppDelegate *)APPDELEGATE).TABBAR];
		[action release];
	}
	else {
		[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
	}

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	@try {
		if (buttonIndex==0) {
			if ([[counting objectAtIndex:0]intValue]==2) {
				[counting replaceObjectAtIndex:0 withObject:@"0"];
				[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
			}
			else {
				NSString *fullmessage=[NSString stringWithFormat:@"%@api/logout/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
				NSURL *url = [NSURL URLWithString:fullmessage];
				ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
				[request startSynchronous];
				NSString *logAns = [request responseString];
				NSError *error = [request error];
				if (error) {
					UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Internet Connection" message:@"It appears that you might not have an internet connection. Please make sure your 3G/WIFI is switched on." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
					[alert show];
					[alert release];
				}
				else {
					SBJsonParser *parse = [[SBJsonParser alloc]init];
					logDetail = [parse objectWithString:logAns error:nil];
					NSString *succ = [logDetail objectForKey:@"success"];
					if ([succ intValue]==1) {
						[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).currCount2 replaceObjectAtIndex:0 withObject:@"0"];
						[((featured *)((TRONAppDelegate *)APPDELEGATE).featureWin).count replaceObjectAtIndex:0 withObject:@"0"];
						[((featured *)((TRONAppDelegate *)APPDELEGATE).featureWin).featureTable reloadData];
						[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
						[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userInput replaceObjectAtIndex:1 withObject:@""];
                        [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).checkStatus replaceObjectAtIndex:0 withObject:@"0"];
						[counting replaceObjectAtIndex:0 withObject:@"0"];
					}
					else {
						UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Tron Notification" message:@"Logout Failed. Please Try again!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
						[alert show];
						[alert release];
					}
				}
			}
		}
	}
	@catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"finally-account");
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
-(void)viewWillAppear:(BOOL)animated
{
	@try {
		[accTable setHidden:NO];
		[((preference *)((TRONAppDelegate *)APPDELEGATE).preferenceVw).save setHidden:YES];
		[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:YES animated:YES];
		if ([[counting objectAtIndex:0]intValue]==0) {
			[blur setHidden:NO];
			[lo startAnimating];
			[ad setHidden:NO]; 
			[outO setTitle:@"Logout"];
			[everyDetail removeAllObjects];
			[((preference *)((TRONAppDelegate *)APPDELEGATE).preferenceVw).getCateData removeAllObjects];
			NSString *fullmessage=[NSString stringWithFormat:@"%@api/user/info/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
			[request setDelegate:self];
			[request startAsynchronous];
		}
		
		if ([[counting objectAtIndex:0]intValue]==2) {
			[blur setHidden:YES];
			[accTable setHidden:YES];
			[outO setTitle:@"Back"];
			[lab2 setText:[NSString stringWithFormat:@"%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).acc objectAtIndex:3]]];
			[lab4 setText:[NSString stringWithFormat:@"%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).acc objectAtIndex:1]]];
			[lab6 setText:[NSString stringWithFormat:@"RM %@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).acc objectAtIndex:0]]];
			[lab8 setText:[NSString stringWithFormat:@"%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).acc objectAtIndex:5]]];
			[lab10 setText:[NSString stringWithFormat:@"%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).acc objectAtIndex:8]]];
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			[dateFormat setDateFormat:@"dd/MM/yyyy"];
			NSDate *realFormat = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).acc objectAtIndex:7]]];
			[dateFormat setDateFormat: @"MMM d, YYYY"];
			NSString *dateString = [dateFormat stringFromDate:realFormat];
			[lab13 setText:dateString];
			NSString *fullmessage=[NSString stringWithFormat:@"%@%@",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).acc objectAtIndex:4]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			UIImage *cellImage = [UIImage imageWithData:[request responseData]];
			[image setImage:cellImage];
			
		}
		[super viewDidAppear:YES];
	}
	@catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"finally");
	}
	/*NSString *fullmessage=[NSString stringWithFormat:@"%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:5]];
	NSURL *url = [NSURL URLWithString:fullmessage];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];*/
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
	switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
		case 0:
		{
			NSString *allAccount = [request responseString];
			SBJsonParser *parse = [[SBJsonParser alloc]init];
			accDetail = [parse objectWithString:allAccount error:nil];
			NSLog(@"ACCDETAIL:%@",accDetail);
            NSString *error = [accDetail objectForKey:@"error_code"];
            NSString *error_mess = [accDetail objectForKey:@"error_message"];
        if ([error intValue]==205) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:error_mess delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            [alert release];
            [((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).currCount2 replaceObjectAtIndex:0 withObject:@"0"];
            [((featured *)((TRONAppDelegate *)APPDELEGATE).featureWin).count replaceObjectAtIndex:0 withObject:@"0"];
            [((featured *)((TRONAppDelegate *)APPDELEGATE).featureWin).featureTable reloadData];
            [((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
            [((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userInput replaceObjectAtIndex:1 withObject:@""];
            [((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).checkStatus replaceObjectAtIndex:0 withObject:@"0"];
            [counting replaceObjectAtIndex:0 withObject:@"0"];
            [((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
        }
        else {
            userDetail = [accDetail objectForKey:@"user"];
			prefer = [accDetail objectForKey:@"preferences"];
			NSLog(@"real pre:%d",[prefer count]);
			NSString *balance = [userDetail objectForKey:@"balance"];
			NSString *accountEXP = [userDetail objectForKey:@"account_expiry_date"];
			NSString *email = [userDetail objectForKey:@"email"];
			NSString *iD = [userDetail objectForKey:@"id"];
			NSString *miss = [userDetail objectForKey:@"msisdn"];
			NSString *name = [userDetail objectForKey:@"name"];
			NSString *profileLogo = [userDetail objectForKey:@"profile_image_url"];
			NSString *tronPoint = [userDetail objectForKey:@"tron_point"];
			[everyDetail addObject:balance];
			[everyDetail addObject:email];
			[everyDetail addObject:iD];
			[everyDetail addObject:name];
			[everyDetail addObject:profileLogo];
			[everyDetail addObject:tronPoint];
			[everyDetail addObject:[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userInput objectAtIndex:1]];
			[everyDetail addObject:accountEXP];
			[everyDetail addObject:miss];
			[counting replaceObjectAtIndex:0 withObject:@"1"];
			NSString *fullmessage=[NSString stringWithFormat:@"%@%@",SERVER,[everyDetail objectAtIndex:4]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			//[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"mode",nil]];
			//[request setDelegate:self];
			[request startSynchronous];
			UIImage *cellImage = [UIImage imageWithData:[request responseData]];
			[image setImage:cellImage];
			[lab2 setText:[NSString stringWithFormat:@"%@",[everyDetail objectAtIndex:3]]];
			[lab4 setText:[NSString stringWithFormat:@"%@",[everyDetail objectAtIndex:1]]];
			[lab6 setText:[NSString stringWithFormat:@"RM %@",[everyDetail objectAtIndex:0]]];
			[lab8 setText:[NSString stringWithFormat:@"%@",[everyDetail objectAtIndex:5]]];
			[lab10 setText:[NSString stringWithFormat:@"%@",[everyDetail objectAtIndex:8]]];
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			[dateFormat setDateFormat:@"dd/MM/yyyy"];
			NSDate *realFormat = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[everyDetail objectAtIndex:7]]];
			[dateFormat setDateFormat: @"MMM d, YYYY"];
			NSString *dateString = [dateFormat stringFromDate:realFormat];
			[lab13 setText:dateString];
			[NSKeyedArchiver archiveRootObject:everyDetail
										toFile:[NSString stringWithFormat:@"%@/message.txt",DOCUMENT]];
			
			for (int i=0; i<[prefer count]; i++) {
				prefreData = [prefer objectAtIndex:i];
				NSString *preID = [prefreData objectForKey:@"id"];
				NSString *prename = [prefreData objectForKey:@"name"];
				NSString *preselect = [prefreData objectForKey:@"selected"];
				[((preference *)((TRONAppDelegate *)APPDELEGATE).preferenceVw).getCateData addObject:preID];
				[((preference *)((TRONAppDelegate *)APPDELEGATE).preferenceVw).getCateData addObject:prename];
				[((preference *)((TRONAppDelegate *)APPDELEGATE).preferenceVw).getCateData addObject:preselect];
			}
        }
		}
	}
	[blur setHidden:YES];
	[lo stopAnimating];
	[ad setHidden:YES];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	accInfo = [[UISegmentedControl alloc]init];
	tools = [[NSArray alloc]initWithObjects:@"My Vouchers",@"Gift Redemption",@"Preferences",nil];
	everyDetail = [[NSMutableArray alloc]init];
	counting = [[NSMutableArray alloc]init];
	((preference *)((TRONAppDelegate *)APPDELEGATE).preferenceVw).getCateData =[[NSMutableArray alloc]init];
	[counting addObject:@"0"];
	[self.high.layer setBorderColor:[[UIColor grayColor] CGColor]];
	[self.high.layer setCornerRadius:8.0];
	[self.high.layer setMasksToBounds:YES];
    self.high.clipsToBounds = YES;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView setBackgroundColor:[UIColor clearColor]];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if(cell==nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"any-cell"] autorelease];
	}
	/*UISwitch *switc=[[UISwitch alloc]initWithFrame:CGRectMake(180, 65, 5, 5)];
	UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(12, 75, 100, 15)];
	label.backgroundColor=[UIColor clearColor];
	label.text=@"Vouchers No";
	NSInteger row=[indexPath row];
	cell.textLabel.text = @"test";
	cell.detailTextLabel.text = @"A";
	cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
	[cell addSubview:switc];
	[cell addSubview:label];*/
	NSInteger row=[indexPath row];
	cell.text = [tools objectAtIndex:row];
	cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//Row for Section
	return [tools count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger row = [indexPath row];
	if (row==2) {
		NSString *row1 = [NSString stringWithFormat:@"%d",row];
		[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).selectedRow replaceObjectAtIndex:0 withObject:row1];
		[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).accountDetailWin animated:YES];
		[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
		[((preference *)((TRONAppDelegate *)APPDELEGATE).preferenceVw).check reloadData];
	}
	else if (row==1)
	{
		[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).giftredeemWin animated:YES];
	}
	else if (row==0)
	{
		NSString *row1 = [NSString stringWithFormat:@"%d",row];
		[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).selectedRow replaceObjectAtIndex:0 withObject:row1];
		[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).accountDetailWin animated:YES];
		[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
	}
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style: UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] autorelease];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//Tells that the row is selected
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[accInfo release];
	[tools release];
	[everyDetail release];
	[counting release];
	[high release];
    [super dealloc];
}


@end
