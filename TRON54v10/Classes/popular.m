    //
//  popular.m
//  TRON
//
//  Created by Wu Ming on 5/2/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "popular.h"


@implementation popular

@synthesize popularArray,popularImage,recommendArray,recommendImage,currCount1,currCount2,currentUserType,storeDate3;
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
-(IBAction)refreshPop
{
	count=0;
	count1=1;
	[barTab setHidden:NO];
	[lo startAnimating];
	[ad setHidden:NO];
	[popularImage removeAllObjects];
	[recommendImage removeAllObjects];
	[recommendArray removeAllObjects];
	[optional setSelectedSegmentIndex:0];
	[selection setTitle:@"Recommend"];
	tit.topItem.title=@"Popular";
	[currCount2 replaceObjectAtIndex:0 withObject:@"0"];
	[((TRONAppDelegate *)APPDELEGATE).discount2Vw removeFromSuperview];
	[((TRONAppDelegate *)APPDELEGATE).cash2Vw removeFromSuperview];
	[((TRONAppDelegate *)APPDELEGATE).gift2Vw removeFromSuperview];
	if (count==0) {
		for (int i=0; i<[popularArray count]/9; i++) {
			[popularImage addObject:@""];
		}
		for (int i=0; i<[popularArray count]/9; i++) {
			NSString *fullmessage=[NSString stringWithFormat:@"%@",[popularArray objectAtIndex:(i*9)+6]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"img",@"0",@"mode",nil]];
			[request setDelegate:self];
			[request startAsynchronous];
		}
	}
}
-(IBAction)segControl:(id)sender
{
	switch ([sender selectedSegmentIndex]) {
		case 0:
		{
			[((TRONAppDelegate *)APPDELEGATE).discount2Vw removeFromSuperview];
			[((TRONAppDelegate *)APPDELEGATE).cash2Vw removeFromSuperview];
			[((TRONAppDelegate *)APPDELEGATE).gift2Vw removeFromSuperview];
			if (count==[popularArray count]/9) {
				for (int i=0; i<[((disCount2 *)((TRONAppDelegate *)APPDELEGATE).discount2Vw).discount2Array count]/9; i++) {
					NSString *dis2 = [NSString stringWithFormat:@"%@",[((disCount2 *)((TRONAppDelegate *)APPDELEGATE).discount2Vw).discount2Array objectAtIndex:(i*9)+8]];
					if ([dis2 isEqual:@""]) {
						for (int k=0; k<[popularArray count]/9; k++) {
							if ([[popularArray objectAtIndex:(k*9)+2]intValue]==2) {
								[((disCount2 *)((TRONAppDelegate *)APPDELEGATE).discount2Vw).discount2Array replaceObjectAtIndex:(i*9)+8 withObject:[popularImage objectAtIndex:k]];
					}
				}
			}
				}
				[((disCount2 *)((TRONAppDelegate *)APPDELEGATE).discount2Vw).discount2Deal reloadData];
				
				for (int i=0; i<[((cash2 *)((TRONAppDelegate *)APPDELEGATE).cash2Vw).cash2Array count]/9; i++) {
					NSString *dis2 = [NSString stringWithFormat:@"%@",[((cash2 *)((TRONAppDelegate *)APPDELEGATE).cash2Vw).cash2Array objectAtIndex:(i*9)+8]];
					if ([dis2 isEqual:@""]) {
						for (int k=0; k<[popularArray count]/9; k++) {
							if ([[popularArray objectAtIndex:(k*9)+2]intValue]==2) {
								[((cash2 *)((TRONAppDelegate *)APPDELEGATE).cash2Vw).cash2Array replaceObjectAtIndex:(i*9)+8 withObject:[popularImage objectAtIndex:k]];
							}
						}
					}
				}
				[((cash2 *)((TRONAppDelegate *)APPDELEGATE).cash2Vw).cash2Deal reloadData];
				
				
				for (int i=0; i<[((gift2 *)((TRONAppDelegate *)APPDELEGATE).gift2Vw).gift2Array count]/9; i++) {
					NSString *dis2 = [NSString stringWithFormat:@"%@",[((gift2 *)((TRONAppDelegate *)APPDELEGATE).gift2Vw).gift2Array objectAtIndex:(i*9)+8]];
					if ([dis2 isEqual:@""]) {
						for (int k=0; k<[popularArray count]/9; k++) {
							if ([[popularArray objectAtIndex:(k*9)+2]intValue]==2) {
								[((gift2 *)((TRONAppDelegate *)APPDELEGATE).gift2Vw).gift2Array replaceObjectAtIndex:(i*9)+8 withObject:[popularImage objectAtIndex:k]];
							}
						}
					}
				}
				[((gift2 *)((TRONAppDelegate *)APPDELEGATE).gift2Vw).gift2Deal reloadData];
				
			}
			break;
		}
		case 1:
		{
			[((disCount2 *)((TRONAppDelegate *)APPDELEGATE).discount2Vw).discount2Array removeAllObjects];
			[((disCount2 *)((TRONAppDelegate *)APPDELEGATE).discount2Vw).discount2Array2 removeAllObjects];
			[((disCount2 *)((TRONAppDelegate *)APPDELEGATE).discount2Vw).discount2Deal reloadData];
			[self.view addSubview:((TRONAppDelegate *)APPDELEGATE).discount2Vw];
			[self.view bringSubviewToFront:bar];
			[self.view bringSubviewToFront:tit];
			break;
		}
		case 2:
		{
			[((cash2 *)((TRONAppDelegate *)APPDELEGATE).cash2Vw).cash2Array removeAllObjects];
			[((cash2 *)((TRONAppDelegate *)APPDELEGATE).cash2Vw).cash2Array2 removeAllObjects];
			[((cash2 *)((TRONAppDelegate *)APPDELEGATE).cash2Vw).cash2Deal reloadData];
			[self.view addSubview:((TRONAppDelegate *)APPDELEGATE).cash2Vw];
			[self.view bringSubviewToFront:bar];
			[self.view bringSubviewToFront:tit];
			break;
		}
		case 3:
		{
			[((gift2 *)((TRONAppDelegate *)APPDELEGATE).gift2Vw).gift2Array removeAllObjects];
			[((gift2 *)((TRONAppDelegate *)APPDELEGATE).gift2Vw).gift2Array2 removeAllObjects];
			[((gift2 *)((TRONAppDelegate *)APPDELEGATE).gift2Vw).gift2Deal reloadData];
			[self.view addSubview:((TRONAppDelegate *)APPDELEGATE).gift2Vw];
			[self.view bringSubviewToFront:bar];
			[self.view bringSubviewToFront:tit];
			break;
		}
	}
}
-(IBAction)recommend:(id)sender{
	if (count1%2==1) {
		[optional setSelectedSegmentIndex:0];
		[currentUserType replaceObjectAtIndex:0 withObject:@"1"];
		[((TRONAppDelegate *)APPDELEGATE).discount2Vw removeFromSuperview];
		[((TRONAppDelegate *)APPDELEGATE).cash2Vw removeFromSuperview];
		[((TRONAppDelegate *)APPDELEGATE).gift2Vw removeFromSuperview];
		[selection setTitle:@"Popular"];
		tit.topItem.title=@"Recommended";
		//[tableData setFrame:CGRectMake(0, 44, 320, 367)];
		[currCount1 replaceObjectAtIndex:0 withObject:@"0"];
		if ([[currCount2 objectAtIndex:0]intValue]==0) {
			[barTab setHidden:NO];
			[lo startAnimating];
			[ad setHidden:NO];
			[recommendArray removeAllObjects];
			[recommendImage removeAllObjects];
			NSString *fullmessage=[NSString stringWithFormat:@"%@api/deal/recommended/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"mode",nil]];
			[request setDelegate:self];
			[request startAsynchronous];
			[currCount2 replaceObjectAtIndex:0 withObject:@"0"];
		}
		else {
			count1=0;
			[tableData reloadData];
		}
		count1=0;
	}
	else {
		[currentUserType replaceObjectAtIndex:0 withObject:@"0"];
		[optional setSelectedSegmentIndex:0];
		[currCount1 replaceObjectAtIndex:0 withObject:@"1"];
		[selection setTitle:@"Recommend"];
		tit.topItem.title=@"Popular";
	//	[tableData setFrame:CGRectMake(0, 87, 320, 324)];
		count1=1;
		[tableData reloadData];
	}

}
-(void)viewWillAppear:(BOOL)animated
{
	if ([[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).button objectAtIndex:0]intValue]==1 ) {
		[selection setEnabled:NO];
	}
	else {
		[selection setEnabled:YES];
	}

	/*[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).voNum setHidden:YES];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).voNum setHidden:YES];*/
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:YES animated:YES];
	if (count==0) {
		for (int i=0; i<[popularArray count]/9; i++) {
			[popularImage addObject:@""];
		}
		for (int i=0; i<[popularArray count]/9; i++) {
			NSString *fullmessage=[NSString stringWithFormat:@"%@",[popularArray objectAtIndex:(i*9)+6]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"img",@"0",@"mode",nil]];
			[request setDelegate:self];
			[request startAsynchronous];
		}
	}
    ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"";

}
-(void)requestFinished:(ASIHTTPRequest *)request
{
	@try {
		switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
			case 0:
			{
				NSLog(@"REQUEST IMG:%d",[[[request userInfo] objectForKey:@"mode"]intValue]);
				[popularImage replaceObjectAtIndex:[[[request userInfo] objectForKey:@"img"]intValue] withObject:[request responseData]];
				[tableData reloadData];
				count++;
				[barTab setHidden:YES];
				[lo stopAnimating];
				[ad setHidden:YES];
				break;
			}
			case 2:
			{
				NSString *recommended = [request responseString];
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				recommendPopular = [parse objectWithString:recommended error:nil];
				recommendDeal = [recommendPopular objectForKey:@"deals"];
                NSString *error = [recommendPopular objectForKey:@"error_code"];
                NSString *errorMess = [recommendPopular objectForKey:@"error_message"];
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
                    NSLog(@"REC:%@",recommendDeal);
                    for (int i=0; i<[recommendDeal count]; i++) {
                        recoPop = [recommendDeal objectAtIndex:i];
                        NSString *data = [recoPop objectForKey:@"data_url"];
                        NSString *end = [recoPop objectForKey:@"is_expiring_soon"];
                        NSString *type = [recoPop objectForKey:@"deal_type"];
                        NSString *iD = [recoPop objectForKey:@"is_selling_fast"];
                        recoPopMec = [recoPop objectForKey:@"merchant"];
                        NSString *data2 = [recoPopMec objectForKey:@"data_url"];
                        NSString *logo = [recoPop objectForKey:@"deal_image_thumbnail_url"];
                        NSString *name = [recoPopMec objectForKey:@"name"];
                        NSString *tite = [recoPop objectForKey:@"title"];
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
                         
                         [storeDate4 addObject:realDayLeft];*/
                        [recommendArray addObject:data];
                        [recommendArray addObject:end];
                        [recommendArray addObject:type];
                        [recommendArray addObject:iD];
                        [recommendArray addObject:data2];
                        [recommendArray addObject:logo];
                        [recommendArray addObject:name];
                        [recommendArray addObject:tite];
                    }
                    for (int i=0; i<[recommendArray count]/8; i++) {
                        [recommendImage addObject:@""];
                    }
                    for (int i=0; i<[recommendArray count]/8; i++) {
                        NSString *fullmessage=[NSString stringWithFormat:@"%@",[recommendArray objectAtIndex:(i*8)+5]];
                        NSURL *url = [NSURL URLWithString:fullmessage];
                        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
                        [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"image",@"4",@"mode",nil]];
                        [request setDelegate:self];
                        [request startAsynchronous];
                    }
                }
				break;
			}
			case 4:
			{
				[recommendImage replaceObjectAtIndex:[[[request userInfo]objectForKey:@"image"]intValue] withObject:[request responseData]];
				[tableData reloadData];
				[barTab setHidden:YES];
				[lo stopAnimating];
				[ad setHidden:YES];
				break;
			}
		}
		NSLog(@"count:%d",count);
		NSLog(@"re:%@",recommendArray);
	}
	@catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"finally-popular");
	}
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	popularArray = [[NSMutableArray alloc]init];
	popularImage = [[NSMutableArray alloc]init];
	count=0;
	count1=1;
	recommendArray = [[NSMutableArray alloc]init];
	recommendImage = [[NSMutableArray alloc]init];
	currCount1 = [[NSMutableArray alloc]init];
	[currCount1 addObject:@"1"];
	currCount2 = [[NSMutableArray alloc]init];
	[currCount2 addObject:@"0"];
	currentUserType = [[NSMutableArray alloc]init];
	[currentUserType addObject:@"0"];
	storeDate3 = [[NSMutableArray alloc]init];
	storeDate4 = [[NSMutableArray alloc]init];
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
	NSInteger row=[indexPath row];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",row]];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:1 withObject:@"5"];
	[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).dealWin animated:YES];
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).run startAnimating];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).loaded setHidden:NO];
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style: UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] autorelease];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dealCell"];
	if(cell==nil){
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"dealCell" owner:self options:nil];
		cell = (UITableViewCell *)[nib objectAtIndex:0];
	}
	NSInteger row=[indexPath row];
	if (count1==1) {
		[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[popularImage objectAtIndex:row]]];
		[((UILabel *)[cell viewWithTag:2]) setText:[popularArray objectAtIndex:(row*9)+7]];
		[((UILabel *)[cell viewWithTag:3]) setText:[popularArray objectAtIndex:(row*9)+8]];
        UILabel *label = (UILabel*)[cell viewWithTag:4];
        [label setFrame:CGRectMake(89.0f, 51.0f, 76.0f, 16.0f)];
		if ([[popularArray objectAtIndex:(row*9)+1]intValue]==1) {
			[((UILabel *)[cell viewWithTag:4]) setHidden:YES];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:NO];
			[((UILabel *)[cell viewWithTag:6]) setHidden:NO];
		}
		else if ([[popularArray objectAtIndex:(row*9)+3]intValue]==1) {
			[((UILabel *)[cell viewWithTag:4]) setHidden:NO];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:NO];
			[((UILabel *)[cell viewWithTag:6]) setHidden:YES];
		}
		else {
			[((UILabel *)[cell viewWithTag:4]) setHidden:YES];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:YES];
			[((UILabel *)[cell viewWithTag:6]) setHidden:YES];
		}
	}
	else if (count1==0) {
		[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[recommendImage objectAtIndex:row]]];
		[((UILabel *)[cell viewWithTag:2]) setText:[recommendArray objectAtIndex:(row*8)+6]];
		[((UILabel *)[cell viewWithTag:3]) setText:[recommendArray objectAtIndex:(row*8)+7]];
		if ([[recommendArray objectAtIndex:(row*8)+1]intValue]==1) {
			[((UILabel *)[cell viewWithTag:4]) setHidden:NO];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:NO];
			[((UILabel *)[cell viewWithTag:6]) setHidden:YES];
		}
		else if ([[recommendArray objectAtIndex:(row*8)+3]intValue]==1) {
			[((UILabel *)[cell viewWithTag:4]) setHidden:YES];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:NO];
			[((UILabel *)[cell viewWithTag:6]) setHidden:NO];
		}
		else {
			[((UILabel *)[cell viewWithTag:4]) setHidden:YES];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:YES];
			[((UILabel *)[cell viewWithTag:6]) setHidden:YES];
		}
	}
	
	//Cell for Row
	return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[cell setBackgroundColor:indexPath.row%2==0 ? [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] :
	 [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//Row for Section
	if (count1==1) {
		return [popularArray count]/9;
	}
	else if (count1==0) {
		return [recommendArray count]/8;
	}
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
	[popularArray release];
	[popularImage release];
	[recommendImage release];
	[recommendArray release];
	[currCount1 release];
	[currCount2 release];
	[currentUserType release];
	[storeDate3 release];
	[storeDate4 release];
    [super dealloc];
}


@end
