    //
//  giftredeem.m
//  TRON
//
//  Created by Wu Ming on 8/22/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "giftredeem.h"


@implementation giftredeem
@synthesize giftArray,picGift;
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
	((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"Gift Redemption";
	[super viewDidAppear:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
     ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"";
}
-(void)viewWillAppear:(BOOL)animated
{
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
            ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"";
	if (count==0) {
		[giftArray removeAllObjects];
		[picGift removeAllObjects];
		counting=0;
		[giftTable reloadData];
		[lo startAnimating];
		[ad setHidden:NO];
		NSString *fullmessage=[NSString stringWithFormat:@"%@api/categories/gift/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
		NSURL *url = [NSURL URLWithString:fullmessage];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
		[request setDelegate:self];
		[request startSynchronous];
		count=1;
	}
	[super viewWillAppear:YES];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
	@try {
		switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
			case 0:
			{
				NSString *gifts = [request responseString];
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				allGift = [parse objectWithString:gifts error:nil];
				NSLog(@"ALL gift:%@",allGift);
				giftDeal = [allGift objectForKey:@"categories"];
				for (int i=0; i<[giftDeal count]; i++) {
					giftData = [giftDeal objectAtIndex:i];
					NSString *data = [giftData objectForKey:@"data_url"];
					NSString *imageThumb = [giftData objectForKey:@"image_thumbnail_url"];
					NSString *image = [giftData objectForKey:@"image_url"];
					NSString *name = [giftData objectForKey:@"name"];
					[giftArray addObject:data];
					[giftArray addObject:imageThumb];
					[giftArray addObject:image];
					[giftArray addObject:name];
					[giftTable reloadData];
				}
				[lo stopAnimating];
				[ad setHidden:YES];
				for (int i=0; i<[giftArray count]/4; i++) {
					[picGift addObject:@""];
				}
				for (int i=0; i<[giftArray count]/4; i++) {
					NSString *fullmessage=[NSString stringWithFormat:@"%@",[giftArray objectAtIndex:(i*4)+2]];
					NSURL *url = [NSURL URLWithString:fullmessage];
					ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
					[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"image",@"2",@"mode",nil]];
					[request setDelegate:self];
					[request startAsynchronous];
				}
				break;
			}
			case 2:
			{
				[picGift replaceObjectAtIndex:[[[request userInfo]objectForKey:@"image"]intValue] withObject:[request responseData]];
				break;
			}
			case 3:
			{
				NSString *searchResult = [request responseString];
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				searchGift = [parse objectWithString:searchResult error:nil];
				NSString *error = [searchGift objectForKey:@"error_code"];
				if ([error intValue]==301 || [error intValue]!=0) {
					UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"No related information was found" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
					[alert show];
					[alert release];
					[lo stopAnimating];
					[ad setHidden:YES];
				}
				else {
					searchAnswer = [searchGift objectForKey:@"deals"];
					for (int i=0; i<[searchAnswer count]; i++) {
						final = [searchAnswer objectAtIndex:i];
						NSString *dataURL = [final objectForKey:@"data_url"];
						NSString *imageLOGO = [final objectForKey:@"deal_image_thumbnail_url"];
						merchant = [final objectForKey:@"merchant"];
						NSString *nameSearcg = [merchant objectForKey:@"name"];
						NSString *titleSearch = [final objectForKey:@"title"];
						[giftArray addObject:dataURL];
						[giftArray addObject:imageLOGO];
						[giftArray addObject:nameSearcg];
						[giftArray addObject:titleSearch];
					}
					for (int i=0; i<[giftArray count]/4; i++) {
						NSString *fullmessage=[NSString stringWithFormat:@"%@",[giftArray objectAtIndex:(i*4)+1]];
						NSURL *url = [NSURL URLWithString:fullmessage];
						ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
						[request startSynchronous];
						[picGift addObject:[request responseData]];
					}
					[lo stopAnimating];
					[ad setHidden:YES];
				}
				count=0;
				break;
			}
		}
		[giftTable reloadData];
	}
	@catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"finally-gift");
	}
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex==0) {
		searching.text=@"";
		[giftArray removeAllObjects];
		[picGift removeAllObjects];
		counting=0;
		[giftTable reloadData];
		[lo startAnimating];
		[ad setHidden:NO];
		NSString *fullmessage=[NSString stringWithFormat:@"%@api/categories/gift/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
		NSURL *url = [NSURL URLWithString:fullmessage];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
		[request setDelegate:self];
		[request startSynchronous];
		count=1;
	}
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	count=0;
	counting=0;
	giftArray = [[NSMutableArray alloc]init];
	picGift = [[NSMutableArray alloc]init];
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
	if (counting==1) {
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",row]];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:1 withObject:@"17"];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).run startAnimating];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).loaded setHidden:NO];
		
		[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).dealWin animated:YES];
		[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
                ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"";
	}
	else {
		NSString *curRow = [NSString stringWithFormat:@"%d",row];
		[((totalGift *)((TRONAppDelegate *)APPDELEGATE).totalGiftWin).counting replaceObjectAtIndex:1 withObject:curRow];
		[((totalGift *)((TRONAppDelegate *)APPDELEGATE).totalGiftWin).counting replaceObjectAtIndex:0 withObject:@"0"];
		[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).totalGiftWin animated:YES];
		[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
        ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"";
	}
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style: UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] autorelease];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (counting==0) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
		if(cell==nil){
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"categoryCell" owner:self options:nil];
			cell = (UITableViewCell *)[nib objectAtIndex:0];
		}
		NSInteger row = [indexPath row];
		[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[picGift objectAtIndex:row]]];
		[((UILabel *)[cell viewWithTag:2]) setText:[giftArray objectAtIndex:(row*4)+3]];	
		return cell;
	}
	else {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dealCell"];
		if (cell==nil) {
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"dealCell" owner:self options:nil];
			cell = (UITableViewCell *)[nib objectAtIndex:0];
		}
		NSInteger row = [indexPath row];
		[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[picGift objectAtIndex:row]]];
		[((UILabel *)[cell viewWithTag:2]) setText:[giftArray objectAtIndex:(row*4)+2]];
		[((UITextView *)[cell viewWithTag:3]) setText:[giftArray objectAtIndex:(row*4)+3]];
		[((UILabel *)[cell viewWithTag:4]) setHidden:YES];
		[((UIImageView *)[cell viewWithTag:5]) setHidden:YES];
		[((UILabel *)[cell viewWithTag:6]) setHidden:YES];
		return cell;
	}
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[cell setBackgroundColor:indexPath.row%2==0 ? [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] :
	 [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f]];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [giftArray count]/4;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
     NSString *searchText = [searching.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	NSString *fullmessage=[NSString stringWithFormat:@"%@api/deal/gift/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b&search=%@",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0],searchText];
	NSURL *url = [NSURL URLWithString:fullmessage];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"mode",nil]];
	[request setDelegate:self];
	[request startAsynchronous];
	[giftArray removeAllObjects];
	[picGift removeAllObjects];
	[giftTable reloadData];
	[lo startAnimating];
	[ad setHidden:NO];
	counting = 1;
	[searching resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{   
	searchBar.text = nil; 
	[searchBar resignFirstResponder];
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
	[giftArray release];
	[picGift release];
    [super dealloc];
}


@end
