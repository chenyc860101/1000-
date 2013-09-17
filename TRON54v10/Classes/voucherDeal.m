    //
//  voucherDeal.m
//  TRON
//
//  Created by Wu Ming on 8/13/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "voucherDeal.h"


@implementation voucherDeal
@synthesize highLighted,getClick,storeDate;


-(IBAction)getDealDetail
{
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d",getID]];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:1 withObject:@"11"];
	[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).dealWin animated:YES];
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).run startAnimating];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).loaded setHidden:NO];
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style: UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] autorelease];
	
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
-(void)viewDidAppear:(BOOL)animated
{
	((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"My Vouchers";
	[super viewDidAppear:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
	@try {
		NSInteger row = [[getClick objectAtIndex:0]intValue];
		[logoDeal setImage:[UIImage imageWithData:[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realLogo objectAtIndex:[[getClick objectAtIndex:0]intValue]]]];
		[titleDes setText:[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData objectAtIndex:(row*7)+3]];
		[ownerName setText:[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:3]];
        NSString *RealPurc = [NSString stringWithFormat:@"%@",[storeDate objectAtIndex:row]];
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"dd/MM/yyyy"];
        NSDate *realFormat = [dateFormat2 dateFromString:[NSString stringWithFormat:@"%@",RealPurc]];
        [dateFormat2 setDateFormat: @"MMM d, YYYY"];
        NSString *dateString = [dateFormat2 stringFromDate:realFormat];
		[purchased setText:dateString];
		[expires setText:[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).displayDate objectAtIndex:(row*2)]];
		[vouNum setText:[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData objectAtIndex:(row*7)]];
		getID = [[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData objectAtIndex:(row*7)+2]intValue];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:0 withObject:[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).realData objectAtIndex:(row*7)+4]];
        ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"";
		[super viewWillAppear:YES];
	}
	@catch (NSException * e) {
			NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"finally-deal");
	}
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self.highLighted.layer setBorderColor:[[UIColor grayColor] CGColor]];
	[self.highLighted.layer setCornerRadius:8.0];
	[self.highLighted.layer setMasksToBounds:YES];
    self.highLighted.clipsToBounds = YES;
	getClick = [[NSMutableArray alloc]init];
	[getClick addObject:@"-1"];
	storeDate = [[NSMutableArray alloc]init];
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

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[storeDate release];
	[getClick release];
	[highLighted release];
    [super dealloc];
}


@end
