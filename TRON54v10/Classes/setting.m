    //
//  setting.m
//  TRON
//
//  Created by Wu Ming on 8/22/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "setting.h"


@implementation setting
@synthesize webSharing;

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
	((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"Sharing";
	[super viewDidAppear:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
	NSInteger dateNumber = [[NSDate date] timeIntervalSince1970];
	NSString *salt = @"P9saCU3e";
	NSString *MD5String = [Utilities returnMD5Hash:[NSString stringWithFormat:@"%@:%@:%d",salt,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userInput objectAtIndex:0],dateNumber]];
	NSString *urlAddress = [NSString stringWithFormat:@"%@mobile/sharing/setup/?username=%@&timestamp=%d&key=%@",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userInput objectAtIndex:0],dateNumber,MD5String];
	
	//Create a URL object.
	NSURL *url = [NSURL URLWithString:urlAddress];
	
	//URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	//Load the request in the UIWebView.
	[webSharing loadRequest:requestObj];
	[super viewWillAppear:YES];
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
	[webSharing release];
    [super dealloc];
}


@end
