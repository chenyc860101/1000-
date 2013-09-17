    //
//  category.m
//  TRON
//
//  Created by Wu Ming on 5/4/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "category.h"


@implementation category
@synthesize cateArray,searching,counting,picCate,count;

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
-(IBAction)refreshCate:(id)sender 
{
    if (count==1) {
        [searching setText:@""];
        [cateArray removeAllObjects];
        [picCate removeAllObjects];
        [categoryMain reloadData];
        counting = 0;
        [loadAni startAnimating];
        [loadtext setHidden:NO];
        NSLog(@"%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]);
        NSString *fullmessage=[NSString stringWithFormat:@"%@api/categories/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
        NSURL *url = [NSURL URLWithString:fullmessage];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
        [request setDelegate:self];
        [request startAsynchronous];
        count=2;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	[searching setText:@""];
	[((totalCategory *)((TRONAppDelegate *)APPDELEGATE).totalCategoryWin).logoTotal removeAllObjects];
	if (count==0) {
		[cateArray removeAllObjects];
		[picCate removeAllObjects];
		[categoryMain reloadData];
		counting = 0;
		[loadAni startAnimating];
		[loadtext setHidden:NO];
		NSLog(@"%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]);
		NSString *fullmessage=[NSString stringWithFormat:@"%@api/categories/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
		NSURL *url = [NSURL URLWithString:fullmessage];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
		[request setDelegate:self];
		[request startSynchronous];
		count=1;
	}
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:YES animated:YES];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
	@try {
		switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
			case 0:
			{
				NSString *categories = [request responseString];
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				allCategory = [parse objectWithString:categories error:nil];
				NSLog(@"ALL category:%@",allCategory);
				categoryDeal = [allCategory objectForKey:@"categories"];
				for (int i=0; i<[categoryDeal count]; i++) {
					categoryData = [categoryDeal objectAtIndex:i];
					NSString *data = [categoryData objectForKey:@"data_url"];
					NSString *imageThumb = [categoryData objectForKey:@"image_thumbnail_url"];
					NSString *image = [categoryData objectForKey:@"image_url"];
					NSString *name = [categoryData objectForKey:@"name"];
					[cateArray addObject:data];
					[cateArray addObject:imageThumb];
					[cateArray addObject:image];
					[cateArray addObject:name];
					[categoryMain reloadData];
				}
				[loadAni stopAnimating];
				[loadtext setHidden:YES];
				for (int i=0; i<[cateArray count]/4; i++) {
					[picCate addObject:@""];
				}
				for (int i=0; i<[cateArray count]/4; i++) {
					NSString *fullmessage=[NSString stringWithFormat:@"%@",[cateArray objectAtIndex:(i*4)+2]];
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
				[picCate replaceObjectAtIndex:[[[request userInfo]objectForKey:@"image"]intValue] withObject:[request responseData]];
                count=1;
				break;
			}
			case 3:
			{
				NSString *searchResult = [request responseString];
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				searchCategory = [parse objectWithString:searchResult error:nil];
				NSString *error = [searchCategory objectForKey:@"error_code"];
				NSLog(@"search:%@",[request responseString]);
				if ([error intValue]==301) {
					UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"No related information was found" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
					[alert show];
					[alert release];
					[loadAni stopAnimating];
					[loadtext setHidden:YES];
				}
				else {
					searchAnwer = [searchCategory objectForKey:@"deals"];
					for (int i=0; i<[searchAnwer count]; i++) {
						finalSearch = [searchAnwer objectAtIndex:i];
						NSString *dataURL = [finalSearch objectForKey:@"data_url"];
						NSString *imageLOGO = [finalSearch objectForKey:@"deal_image_thumbnail_url"];
						NSString *sellingSta = [finalSearch objectForKey:@"is_expiring_soon"];
						merchant = [finalSearch objectForKey:@"merchant"];
						NSString *nameSearcg = [merchant objectForKey:@"name"];
						NSString *titleSearch = [finalSearch objectForKey:@"title"];
						[cateArray addObject:dataURL];
						[cateArray addObject:imageLOGO];
						[cateArray addObject:nameSearcg];
						[cateArray addObject:titleSearch];
						[cateArray addObject:sellingSta];
					}
					for (int i=0; i<[cateArray count]/5; i++) {
						NSString *fullmessage=[NSString stringWithFormat:@"%@",[cateArray objectAtIndex:(i*5)+1]];
						NSURL *url = [NSURL URLWithString:fullmessage];
						ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
						[request startSynchronous];
						[picCate addObject:[request responseData]];
					}
					[loadAni stopAnimating];
					[loadtext setHidden:YES];
				}
				count=1;
				break;
			}
		}
		[categoryMain reloadData];
		
	}
	@catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"Finally-Cate");
	}
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex==0) {
		searching.text=@"";
		[cateArray removeAllObjects];
		[picCate removeAllObjects];
		[categoryMain reloadData];
		counting = 0;
		[loadAni startAnimating];
		[loadtext setHidden:NO];
		NSLog(@"%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]);
		NSString *fullmessage=[NSString stringWithFormat:@"%@api/categories/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
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
	cateArray= [[NSMutableArray alloc]init];
	picCate = [[NSMutableArray alloc]init];
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
        count=1;
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",row]];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:1 withObject:@"15"];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).run startAnimating];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).loaded setHidden:NO];
		
		[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).dealWin animated:YES];
		[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
                ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"";
	}
	else {
		NSString *curRow = [NSString stringWithFormat:@"%d",row];
		[((totalCategory *)((TRONAppDelegate *)APPDELEGATE).totalCategoryWin).counting replaceObjectAtIndex:1 withObject:curRow];
		[((totalCategory *)((TRONAppDelegate *)APPDELEGATE).totalCategoryWin).counting replaceObjectAtIndex:0 withObject:@"0"];
		NSLog(@"array:%@",cateArray);
		[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).totalCategoryWin animated:YES];
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
		[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[picCate objectAtIndex:row]]];
		[((UILabel *)[cell viewWithTag:2]) setText:[cateArray objectAtIndex:(row*4)+3]];	
		return cell;
	}
	else {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dealCell"];
		if (cell==nil) {
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"dealCell" owner:self options:nil];
			cell = (UITableViewCell *)[nib objectAtIndex:0];
		}
		NSInteger row = [indexPath row];
		[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[picCate objectAtIndex:row]]];
		[((UILabel *)[cell viewWithTag:2]) setText:[cateArray objectAtIndex:(row*5)+2]];
		[((UITextView *)[cell viewWithTag:3]) setText:[cateArray objectAtIndex:(row*5)+3]];
		if ([[cateArray objectAtIndex:4]intValue]==0) {
			[((UILabel *)[cell viewWithTag:4]) setHidden:YES];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:YES];
			[((UILabel *)[cell viewWithTag:6]) setHidden:YES];
		}
		else {
			[((UILabel *)[cell viewWithTag:4]) setHidden:NO];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:NO];
			[((UILabel *)[cell viewWithTag:6]) setHidden:YES];
		}
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
	if (counting==0) {
		return [cateArray count]/4;
	}
	else {
		return [cateArray count]/5;
	}
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{   
    NSString *searchText = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	NSString *fullmessage=[NSString stringWithFormat:@"%@api/deal/search/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b&search=%@",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0],searchText];
	NSURL *url = [NSURL URLWithString:fullmessage];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"mode",nil]];
	[request setDelegate:self];
	[request startAsynchronous];
	[cateArray removeAllObjects];
	[picCate removeAllObjects];
	[categoryMain reloadData];
	[loadAni startAnimating];
	[loadtext setHidden:NO];
	counting = 1;
	[searchBar resignFirstResponder];
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
	[cateArray release];
	[picCate release];
	[searching release];
    [super dealloc];
}


@end
