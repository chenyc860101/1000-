    //
//  showAddress.m
//  TRON
//
//  Created by Wu Ming on 5/22/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "showAddress.h"


@implementation showAddress
@synthesize outletTable;

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
	((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=[NSString stringWithFormat:@"%@",[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).allDetail objectAtIndex:12]];
	[super viewDidAppear:YES];
}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"CLICK");
	NSString *row = [NSString stringWithFormat:@"%d",[indexPath row]];
	[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).showMapWin animated:YES];
	[((showMap *)((TRONAppDelegate *)APPDELEGATE).showMapWin).selec replaceObjectAtIndex:0 withObject:row];
	self.navigationItem.backBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:@"Back"
									  style: UIBarButtonItemStyleBordered
									 target:nil
									 action:nil] autorelease];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"address"];
	if(cell==nil){
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"address" owner:self options:nil];
		cell = (UITableViewCell *)[nib objectAtIndex:0];
	}
	NSInteger row=[indexPath row];
	[((UITextView *)[cell viewWithTag:1]) setText:[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).outletDetail objectAtIndex:(row*5)]];
	
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
	return [((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).outletDetail count]/5 ;
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
    [super dealloc];
}


@end
