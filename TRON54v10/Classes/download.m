    //
//  download.m
//  TRON
//
//  Created by Wu Ming on 3/30/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "download.h"


@implementation download
@synthesize image,dealTyped,troncash,highlighted1,quantity,count,LogoData,checkList,smsChar;

-(IBAction)confirm:(id)sender
{
	NSString *fullmessage=[NSString stringWithFormat:@"%@",[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity objectAtIndex:4]];
	NSURL *url = [NSURL URLWithString:fullmessage];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request addPostValue:[NSString stringWithFormat:@"%@",[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]] forKey:@"loginKey"];
	[request addPostValue:@"bdd2279f-ba2b-4c78-816b-1d438037461b" forKey:@"apiKey"];
	[request addPostValue:[NSString stringWithFormat:@"%@",quantity.text] forKey:@"quantity"];
	[request addPostValue:[NSString stringWithFormat:@"%@",[paymentType objectAtIndex:0]] forKey:@"ms_type"];
	[request startSynchronous];				
	NSString *really = [request responseString];
	SBJsonParser *parse = [[SBJsonParser alloc]init];
	totalPayed = [parse objectWithString:really error:nil];
	NSLog(@"TOTAL:%@",totalPayed);
	NSString *error = [totalPayed objectForKey:@"error_code"];
    NSString *errorMess = [totalPayed objectForKey:@"error_message"];
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
	else if ([error intValue]==405 || [error intValue]==413 || [error intValue]==409) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tron Notification"
														message:@"Invalid Payment Method" 
													   delegate:self 
											  cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else if ([error intValue]==401) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tron Notification"
														message:@"Invalid Quantity" 
													   delegate:self 
											  cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else if ([error intValue]==404) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"Insufficient credit or tron points" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
    else if (![error intValue]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:errorMess delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
		[alert release];
    }
	else {
		NSString *completeUrl = [totalPayed objectForKey:@"complete_url"];
		NSString *quant = [totalPayed objectForKey:@"quantity"];
		checkoutDeal = [totalPayed objectForKey:@"deal"];
		NSString *amount = [checkoutDeal objectForKey:@"amount"];
		NSString *label = [checkoutDeal objectForKey:@"amount_label"];
		NSString *subTotal = [totalPayed objectForKey:@"subtotal"];
		NSString *talkTime = [totalPayed objectForKey:@"talktime"];
		NSString *totalAmount = [totalPayed objectForKey:@"total_amount"];
		NSString *totalPoint = [totalPayed objectForKey:@"total_amount_display"];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:2 withObject:completeUrl];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:0 withObject:quant];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalAmount replaceObjectAtIndex:0 withObject:amount];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalAmount replaceObjectAtIndex:1 withObject:label];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalAmount replaceObjectAtIndex:2 withObject:subTotal];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalAmount replaceObjectAtIndex:3 withObject:talkTime];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalAmount replaceObjectAtIndex:4 withObject:totalAmount];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalAmount replaceObjectAtIndex:5 withObject:totalPoint];
		[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).comfirmWin animated:YES];
		self.navigationItem.backBarButtonItem =
		[[[UIBarButtonItem alloc] initWithTitle:@"Back"
										  style: UIBarButtonItemStyleBordered
										 target:nil
										 action:nil] autorelease];
	}
}
-(IBAction)textFieldDoneEdit:(id)sender
{
	[quantity resignFirstResponder];
	NSInteger quan = [quantity.text intValue];
	double actual = [[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).allDetail objectAtIndex:3]doubleValue];
	if ([[dealTyped objectAtIndex:0]intValue]==0 && [[dealTyped objectAtIndex:1]intValue]==1) {
		NSString *total = [NSString stringWithFormat:@"%.0f",(actual*quan)];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:5 withObject:total];
		[totalPrice setText:total];
	}
	else {
		NSString *total = [NSString stringWithFormat:@"RM%.2f",(actual*quan)];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:5 withObject:total];
		[totalPrice setText:total];
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
-(void)textFieldShouldEndEditing:(UITextField *)textField
{
	
}
-(void)viewDidAppear:(BOOL)animated
{
	((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"Confirm Quantity";
	[super viewDidAppear:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	count=0;
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).loaded setHidden:NO];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).run startAnimating];
	[image setImage:[UIImage imageNamed:@""]];
	[quantity setHidden:NO];
	[quanO setHidden:YES];
	[quantity setText:@"1"];
	[paymentType replaceObjectAtIndex:0 withObject:@"0"];
	[troncash setHidden:NO];
	[price setHidden:NO];
	[equalTotal setHidden:NO];
	[totalTitle setHidden:NO];
	[totalPrice setHidden:NO];
	[priceTitle setHidden:NO];
	[multiPly setHidden:NO];
	[noteTitle setHidden:YES];
	[noteMessage setHidden:YES];
	[noteMessage2 setHidden:NO];
	[paidType setHidden:NO];
	if ([[dealTyped objectAtIndex:0]intValue]==1 && [[dealTyped objectAtIndex:1]intValue]==1) {
		[paidType setText:@"Note: This deal will be paid by Tron Talktime"];
		NSString *realPrice = [NSString stringWithFormat:@"RM%@",[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).allDetail objectAtIndex:3]];
		[price setText:realPrice];
		[totalPrice setText:realPrice];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:1 withObject:realPrice];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:5 withObject:realPrice];
		[highlighted1 setFrame:CGRectMake(7, 17, 306, 305)];
		[conf setFrame:CGRectMake(93, 280, 133, 32)];
		[price setHidden:YES];
		[equalTotal setHidden:YES];
		[totalTitle setHidden:YES];
		[totalPrice setHidden:YES];
		[priceTitle setHidden:YES];
		[multiPly setHidden:YES];
		[noteTitle setHidden:NO];
		[noteMessage setHidden:NO];
		[paidType setHidden:YES];
		[noteMessage2 setHidden:YES];
	}
	else if ([[dealTyped objectAtIndex:0]intValue]==1 && [[dealTyped objectAtIndex:1]intValue]==0) {
		[paidType setText:@"Note: This deal will be paid by Tron Cash"];
		NSString *realPrice = [NSString stringWithFormat:@"RM%@",[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).allDetail objectAtIndex:3]];
		[price setText:realPrice];
		[totalPrice setText:realPrice];
		[highlighted1 setFrame:CGRectMake(7, 17, 306, 344)];
		[conf setFrame:CGRectMake(93, 316, 133, 32)];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:1 withObject:realPrice];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:5 withObject:realPrice];
	}
	else if ([[dealTyped objectAtIndex:0]intValue]==0 && [[dealTyped objectAtIndex:1]intValue]==1) {
		[paidType setText:@"Note: This deal will be paid by Tron Points"];
		NSString *realPrice = [NSString stringWithFormat:@"%d",[[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).allDetail objectAtIndex:3]intValue]];
		[price setText:realPrice];
		[totalPrice setText:realPrice];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:1 withObject:realPrice];
		[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:5 withObject:realPrice];

	}
	[name setText:[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).allDetail objectAtIndex:12]];
	[descr setText:[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).allDetail objectAtIndex:26]];
	[image setImage:[UIImage imageWithData:[LogoData objectAtIndex:0]]];
	[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:3 withObject:[LogoData objectAtIndex:0]];
	[((accountDetail *)((TRONAppDelegate *)APPDELEGATE).accountDetailWin).cateTable reloadData];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self.highlighted1.layer setBorderColor:[[UIColor grayColor] CGColor]];
	[self.highlighted1.layer setCornerRadius:8.0];
	[self.highlighted1.layer setMasksToBounds:YES];
    self.highlighted1.clipsToBounds = YES;
	checkList = [[NSMutableArray alloc]init];
	[checkList addObject:@"1"];
	[checkList addObject:@"0"];
	LogoData = [[NSMutableArray alloc]init];
	[LogoData addObject:@""];
	dealTyped = [[NSMutableArray alloc]init];
	[dealTyped addObject:@"0"];
	[dealTyped addObject:@"0"];
	finalDeci = [[NSMutableArray alloc]init];
	[finalDeci addObject:@"0"];
	paymentType = [[NSMutableArray alloc]init];
	[paymentType addObject:@"0"];
    [paymentType addObject:@"0"];
    [paymentType addObject:@"0"];
	count=0;
	list = [[NSArray alloc]initWithObjects:@"Send e-Voucher via SMS",@"Send e-Voucher via MMS",nil];
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	tableView.backgroundColor=[UIColor clearColor];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if(cell==nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"any-cell"] autorelease];
	}
	NSInteger row = [indexPath row];
	[cell setText:[list objectAtIndex:row]];
	
	if ([[checkList objectAtIndex:row]intValue]==1) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
		old=indexPath;
        [paymentType replaceObjectAtIndex:2 withObject:old];
        [paymentType replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",[old row]]];
	}
	else {
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
	//Cell for Row
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	NSInteger row2 = [[paymentType objectAtIndex:1]intValue];
	UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
	UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:[paymentType objectAtIndex:2]];
	if (row!=row2) {
		[paymentType replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",row]];
		[newCell setAccessoryType:UITableViewCellAccessoryCheckmark];
		[oldCell setAccessoryType:UITableViewCellAccessoryNone];
		old = indexPath;
        [paymentType replaceObjectAtIndex:2 withObject:old];
        [paymentType replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",[old row]]];
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//Row for Section
	return 2;
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
	[list release];
	[checkList release];
	[LogoData release];
	[dealTyped release];
	[finalDeci release];
	[paymentType release];
	[image release];
	[troncash release];
	[highlighted1 release];
	[quantity release];
	[LogoData release];
    [super dealloc];
}


@end
