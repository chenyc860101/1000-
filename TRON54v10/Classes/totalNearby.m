    //
//  totalNearby.m
//  TRON
//
//  Created by Wu Ming on 5/19/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "totalNearby.h"


@implementation totalNearby
@synthesize infoNeed,lo,ad,nearTotal,counting,getCurrent,nearImage;

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
	[super viewWillAppear:YES];
	if ([[counting objectAtIndex:0]intValue]==0) {
		NSLog(@"total:%@",infoNeed);
		[nearImage removeAllObjects];
		for (int i=0; i<[infoNeed count]/4; i++) {
			[nearImage addObject:@""];
		}
		for (int i=0; i<[infoNeed count]/4; i++) {
			NSString *fullmessage=[NSString stringWithFormat:@"%@",[infoNeed objectAtIndex:(i*4)+3]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i],@"img",@"0",@"mode",nil]];
			[request setDelegate:self];
			[request startAsynchronous];
		}
	}
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
	switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
		case 0:
		{
			[nearImage replaceObjectAtIndex:[[[request userInfo] objectForKey:@"img"]intValue] withObject:[request responseData]];
			[nearTotal reloadData];
			break;
		}
	}
	[lo stopAnimating];
	[ad setHidden:YES];
	
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	infoNeed = [[NSMutableArray alloc]init];
	counting = [[NSMutableArray alloc]init];
	nearImage = [[NSMutableArray alloc]init];
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
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:1 withObject:@"12"];
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
	[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[nearImage objectAtIndex:row]]];
	[((UILabel *)[cell viewWithTag:2]) setText:[infoNeed objectAtIndex:(row*4)+2]];
	[((UILabel *)[cell viewWithTag:3]) setText:[infoNeed objectAtIndex:(row*4)+1]];
    [((UILabel *)[cell viewWithTag:4]) setHidden:YES];
	
	return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[cell setBackgroundColor:indexPath.row%2==0 ? [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f] :
	 [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f]];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [infoNeed count]/4;
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
	[infoNeed release];
	[counting release];
	[nearImage release];
	[nearTotal release];
	[lo release];
	[ad release];
	[getCurrent release];
    [super dealloc];
}


@end
