    //
//  deals.m
//  TRON
//
//  Created by Wu Ming on 3/25/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "deals.h"


@implementation deals
@synthesize image,allDetail,row,run,totalBuy,totalDiscount,totalValue,totalSave,price,name,loaded,nameBought,nameDis,nameValue,nameSave,redeem,username,outletDetail,ground,ground2,scroll,highlight2;



-(IBAction)tab:(id)sender
{
	if ([sender selectedSegmentIndex]==0) {
		[highlight2 setAlpha:1.0f];
		[rules setHidden:YES];
		[rules2 setHidden:YES];
		[infinis setHidden:NO];
		[liting setHidden:NO];
		[infinis setHidden:NO];
		[comLogo setHidden:YES];
		[comName setHidden:YES];
		[highlight setText:@""];
		[self performSelector:@selector(solution2) withObject:nil afterDelay:0.0];
		NSLog(@"high%f",highlight.contentSize.height);
		NSLog(@"scroll%f",scroll.contentSize.height);
		
	}
	else if ([sender selectedSegmentIndex]==1)
	{
		[comFace setHidden:NO];
		[comTwi setHidden:NO];
		[comSite2 setHidden:NO];
		[comTelep setHidden:NO];
		[highlight2 setAlpha:0.0f];
		[highlight2 loadHTMLString:@"<html><head></head><body></body></html>" baseURL:nil];
		[rules setHidden:YES];
		[rules2 setHidden:YES];
		[infinis setHidden:YES];
		[infinis2 setHidden:YES];
		[liting setHidden:YES];
		[comLogo setHidden:NO];
		[comName setHidden:NO];
		if ([comSite isEqual:@""]) {
			[comSite2 setHidden:YES];
		}
		if ([twitter isEqual:@""]) {
			[comTwi setHidden:YES];
		}
		if ([facebook isEqual:@""]) {
			[comFace setHidden:YES];
		}
		if ([comTel isEqual:@""]) {
			[comTelep setHidden:YES];
		}
		
		[highlight setText:@""];
		[self performSelector:@selector(solution) withObject:nil afterDelay:0.2];
	}
}

-(void)solution2
{
	NSInteger lengthHigh = [[allDetail objectAtIndex:5] length];
	NSInteger lengthTerm = [[allDetail objectAtIndex:25] length];
	[comSite2 setHidden:YES];
	[comTelep setHidden:YES];
	[comFace setHidden:YES];
	[comTwi setHidden:YES];
	[highlight setHidden:YES];
	[highlight2 setHidden:YES];
	/*if (lengthHigh==0 && lengthTerm==0) {
		NSString *tabone = [NSString stringWithFormat:@""];
		[highlight setText:tabone];
	}	
	else if (lengthHigh==0) {
		NSString *tabone = [NSString stringWithFormat:@"Terms & Conditions: \n %@",[allDetail objectAtIndex:25]];
		[highlight setText:tabone];
	}
	else if (lengthTerm==0) {
		NSString *tabone = [NSString stringWithFormat:@"Highlights: \n%@",[allDetail objectAtIndex:5]];
		[highlight setText:tabone];
	}
	else {
		NSString *tabone = [NSString stringWithFormat:@"Highlights: \n%@ \n\nTerms & Conditions: \n %@",[allDetail objectAtIndex:5],[allDetail objectAtIndex:25]];
		[highlight setText:tabone];
	}*/
	
	NSLog(@"length:::%d",[[allDetail objectAtIndex:33]length]);
	scroll.contentSize=CGSizeMake(320, [[allDetail objectAtIndex:33]length]+180);
	CGRect webFrame = CGRectMake(14, 300, 290, [[allDetail objectAtIndex:33]length]);
	[ground setFrame:CGRectMake(6, 250, 308, [[allDetail objectAtIndex:33]length]+50)];
	highlight2 = [[UIWebView alloc] initWithFrame:webFrame];
	[highlight2 setDelegate:self];
	[highlight2 setOpaque:NO];
	highlight2.backgroundColor = [UIColor clearColor];  
	[self.scroll addSubview:highlight2];  
	[highlight2 loadHTMLString:[NSString stringWithFormat:@"%@%@",[allDetail objectAtIndex:34],[allDetail objectAtIndex:33]] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];  
	//[[[highlight2 subviews] lastObject] setScrollEnabled:NO];
	UIView* pRow = nil;
	for(pRow in highlight2.subviews){
		if([pRow isKindOfClass:[UIScrollView class] ]){
			UIScrollView* pScrollRow = (UIScrollView*) pRow;
			pScrollRow.scrollEnabled = NO;
			pScrollRow.bounces = NO;
		}
	}
	/*NSLog(@"Size:::%d",highlight2.frame.size.height);
	CGRect frame = highlight.frame;
	frame.size.height= highlight.contentSize.height;
	NSLog(@"123::%f",highlight.contentSize.height);
	[highlight setFrame:CGRectMake(14, 346, frame.size.width, frame.size.height)];
	[rules setFrame:CGRectMake(16, 335+highlight.contentSize.height, 94, 19)];
	[rules2 setFrame:CGRectMake(103, 335+highlight.contentSize.height, 135, 18)];
	highlight.frame=frame;
	if (highlight.contentSize.height==36) {
		scroll.contentSize=CGSizeMake(320, (highlight.contentSize.height));
	}
	else {
		NSInteger sum = (highlight.contentSize.height-36);
		scroll.contentSize=CGSizeMake(320, (highlight.contentSize.height+400));
	}*/
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
    [ground setFrame:CGRectMake(6, 250, 308, fittingSize.height+100)];
    scroll.contentSize=CGSizeMake(320, fittingSize.height+400);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if(navigationType ==  UIWebViewNavigationTypeLinkClicked) {
		[[UIApplication sharedApplication] openURL:request.URL];
		return NO;
	}
	else 
		return YES;
}
-(void)buttonClick
{
	[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://mmp.tron.com.my/common/static/universal-terms/"]];
}
-(void)solution
{
	[highlight2 setHidden:YES];
	[highlight setHidden:NO];
	NSString *tabthree = [NSString stringWithFormat:@"%@",[allDetail objectAtIndex:9]];
	[highlight setText:tabthree];
	CGRect frame = highlight.frame;
	frame.size.height= highlight.contentSize.height;
	highlight.frame=frame;
	[highlight setFrame:CGRectMake(14, 374, frame.size.width, frame.size.height)];
	if (highlight.contentSize.height==36) {
		scroll.contentSize=CGSizeMake(320, (highlight.contentSize.height));
		//[outlet setFrame:CGRectMake(32, 280, 255, 37)];
		[ground setFrame:CGRectMake(6, 250, 308, 151)];
		//[highlight setFrame:CGRectMake(14, 289, 290, 91)];
	}
	else {
		NSInteger sum = (highlight.contentSize.height-36);
		NSLog(@"sum:%d",sum);
		scroll.contentSize=CGSizeMake(320, (highlight.contentSize.height+400));
		//[outlet setFrame:CGRectMake(32, (306+sum), 255, 37)];
		[ground setFrame:CGRectMake(6, 250, 308, 170+sum)];
		//[highlight setFrame:CGRectMake(14, 289, 300, 141+sum)];
	}	
}
-(IBAction)buy:(id)sender
{
	if ([[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).button objectAtIndex:0]intValue]==0 ) {
        NSLog(@"buybuy");
		NSString *fullmessage=[NSString stringWithFormat:@"%@api/deal/%@/checkout/",SERVER,[allDetail objectAtIndex:6]];
		NSURL *url = [NSURL URLWithString:fullmessage];
		ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
		[request addPostValue:[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0] forKey:@"loginKey"];
		[request addPostValue:@"bdd2279f-ba2b-4c78-816b-1d438037461b" forKey:@"apiKey"];
		[request startSynchronous];
		NSString *shareDetail = [request responseString];
		SBJsonParser *parse = [[SBJsonParser alloc]init];
		totalShare = [parse objectWithString:shareDetail error:nil];
		NSLog(@"TOTAL:%@",totalShare);
		NSString *confirmURL = [totalShare objectForKey:@"confirm_url"];
		NSString *error = [totalShare objectForKey:@"error_code"];
		NSString *errorMess = [totalShare objectForKey:@"error_message"];
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
		else if (![error intValue]==0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:errorMess delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		else {
			[((comfirm *)((TRONAppDelegate *)APPDELEGATE).comfirmWin).totalQuantity replaceObjectAtIndex:4 withObject:confirmURL];
			int po = [[allDetail objectAtIndex:27]intValue];
			if (po==3) {
				[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).dealTyped replaceObjectAtIndex:0 withObject:@"0"];
				[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).dealTyped replaceObjectAtIndex:1 withObject:@"1"];
			}
			else if (po==2) {
				[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).dealTyped replaceObjectAtIndex:0 withObject:@"1"];
				[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).dealTyped replaceObjectAtIndex:1 withObject:@"0"];
			}
			else if (po==1) {
				[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).dealTyped replaceObjectAtIndex:0 withObject:@"1"];
				[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).dealTyped replaceObjectAtIndex:1 withObject:@"1"];
			}
			[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).troncash reloadData];
			[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).downloadWin animated:YES];
			self.navigationItem.backBarButtonItem =
			[[[UIBarButtonItem alloc] initWithTitle:@"Back"
											  style: UIBarButtonItemStyleBordered
											 target:nil
											 action:nil] autorelease];
		}
	}
	else {
		[((TRONAppDelegate *)APPDELEGATE).TABBAR setHidden:YES];
		[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userInput replaceObjectAtIndex:1 withObject:@""];
		[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:YES];
		[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tron Notification" message:@"Please login to buy/download deal." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

}
-(IBAction)merchantClick:(UIButton *)sender
{
	switch ([sender tag]) {
		case 0:
		{
			[[UIApplication sharedApplication]openURL:[NSURL URLWithString:[allDetail objectAtIndex:31]]];
			break;
		}
		case 1:
		{
            UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"Call %@",[allDetail objectAtIndex:32]],@"Add to Contact", nil];
            [action showInView:self.view];
            [action release];
			break;
		}
		case 2:
		{
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[allDetail objectAtIndex:10]]];
			break;
		}
		case 3:
		{
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[allDetail objectAtIndex:13]]];
			break;
		}
		default:
			break;
	}
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",[allDetail objectAtIndex:32]];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phoneNumber]]==0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"Your current device does not support call function" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        }
    }
    else if (buttonIndex == 1) {
        ABUnknownPersonViewController *unknownPersonViewController = [[ABUnknownPersonViewController alloc] init];
        unknownPersonViewController.displayedPerson = (ABRecordRef)[self buildContactDetails];
        unknownPersonViewController.allowsAddingToAddressBook = YES;
        [self.navigationController pushViewController:unknownPersonViewController animated:YES];
        [unknownPersonViewController release]; 
    }
}
- (ABRecordRef)buildContactDetails {
    ABRecordRef person = ABPersonCreate(); 
    CFErrorRef  error = NULL;  
    
    ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    
    bool didAddPhone = ABMultiValueAddValueAndLabel(multiPhone, [allDetail objectAtIndex:32], kABPersonPhoneMobileLabel, NULL);
    
    if(didAddPhone){
        
        ABRecordSetValue(person, kABPersonPhoneProperty, multiPhone,nil);
        
    }
    
    CFRelease(multiPhone);
    
    if (error != NULL) 
        NSLog(@"Error: %@", error);
    
    [(id)person autorelease];
    return person;
}
-(IBAction)showOutlet:(id)sender
{
	/*if ([[((TRONAppDelegate *)APPDELEGATE).device objectAtIndex:0]isEqual:@"iPod1,1"] || [[((TRONAppDelegate *)APPDELEGATE).device objectAtIndex:0]isEqual:@"iPod2,1"] || [[((TRONAppDelegate *)APPDELEGATE).device objectAtIndex:0]isEqual:@"iPhone1,1"]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"Your current device is not support this function" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}*/
    [((showAddress *)((TRONAppDelegate *)APPDELEGATE).showAddressWin).outletTable reloadData];
    [((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).showAddressWin animated:YES];
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
										  style: UIBarButtonItemStyleBordered
										 target:nil
										 action:nil] autorelease];
}

-(IBAction)sharing:(id)sender
{
	[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).sharingPageWin animated:YES];
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
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"";
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
    ((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=@"";
	[rules setHidden:YES];
	[rules2 setHidden:YES];
	[rules setUserInteractionEnabled:YES];
	[highlight2 loadHTMLString:@"<html><head></head><body></body></html>" baseURL:nil];
	[rules addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
	[timer invalidate];
	[scroll setContentOffset:CGPointMake(0,0) animated:NO];
	[left setHidden:YES];
	[mom setHidden:YES];
	[price setHidden:YES];
	[buy setHidden:YES];
	[share setHidden:YES];
	[blur setHidden:NO];
	[run startAnimating];
	[loaded setHidden:NO];
	[run2 startAnimating];
	[loaded2 setHidden:NO];
	[outlet setHidden:YES];
	[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).checkList replaceObjectAtIndex:0 withObject:@"1"];
	[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).checkList replaceObjectAtIndex:1 withObject:@"0"];
	((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).count =0;
	[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).smsChar reloadData];
}
-(void)viewDidAppear:(BOOL)animated
{
	@try {
		[realInfo setSelectedSegmentIndex:0];
		timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
		[outletDetail removeAllObjects];
		[storeUser removeAllObjects];
		[allDetail removeAllObjects];
		((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).count =0;
		[messSold setHidden:YES];
		[blur setHidden:NO];
		[price setHidden:YES];
		[buy setHidden:YES];
		[share setHidden:YES];
		[left setHidden:YES];
		[mom setHidden:YES];
		[line1 setText:@"The deal is on!"];
		[allDetail removeAllObjects];
		[redeem setHidden:YES];
		[username setHidden:YES];
		[buy setHidden:NO];
		[share setHidden:NO];
		[super viewDidAppear:NO];
		if ([[row objectAtIndex:1]intValue] == 0) {
			num = [[row objectAtIndex:0]intValue];
			NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((featured *)((TRONAppDelegate *)APPDELEGATE).featureWin).dealInfo objectAtIndex:(num*9)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		else if ([[row objectAtIndex:1]intValue]==2)
		{
			num = [[row objectAtIndex:0]intValue];
			NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((hot *)((TRONAppDelegate *)APPDELEGATE).hotWin).hotArray objectAtIndex:(num*8)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		else if ([[row objectAtIndex:1]intValue]==5)
		{
			num = [[row objectAtIndex:0]intValue];
			if ([[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).currCount1 objectAtIndex:0]intValue]==1) {
				fullmessage2=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray objectAtIndex:(num*9)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
				
			}
			else if ([[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).currCount1 objectAtIndex:0]intValue]==0) {
				fullmessage2=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendArray objectAtIndex:(num*8)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
				
				
			}
			NSURL *url = [NSURL URLWithString:fullmessage2];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		else if ([[row objectAtIndex:1]intValue]==6)
		{
			num = [[row objectAtIndex:0]intValue];
			[buy setImage:[UIImage imageNamed:@"buybutton.png"] forState:UIControlStateNormal];
			[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).dealTyped replaceObjectAtIndex:0 withObject:@"0"];
			NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((disCount2 *)((TRONAppDelegate *)APPDELEGATE).discount2Vw).discount2Array objectAtIndex:(num*10)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		else if ([[row objectAtIndex:1]intValue]==7)
		{
			num = [[row objectAtIndex:0]intValue];
			[buy setImage:[UIImage imageNamed:@"buybutton.png"] forState:UIControlStateNormal];
			[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).dealTyped replaceObjectAtIndex:0 withObject:@"0"];
			NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((cash2 *)((TRONAppDelegate *)APPDELEGATE).cash2Vw).cash2Array objectAtIndex:(num*10)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		else if ([[row objectAtIndex:1]intValue]==8)
		{
			num = [[row objectAtIndex:0]intValue];
			[buy setImage:[UIImage imageNamed:@"free.png"] forState:UIControlStateNormal];
			[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).dealTyped replaceObjectAtIndex:0 withObject:@"1"];
			NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((gift2 *)((TRONAppDelegate *)APPDELEGATE).gift2Vw).gift2Array objectAtIndex:(num*10)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		else if ([[row objectAtIndex:1]intValue]==9)
		{
			[((totalCategory *)((TRONAppDelegate *)APPDELEGATE).totalCategoryWin).counting replaceObjectAtIndex:0 withObject:@"1"];
			num = [[row objectAtIndex:0]intValue];
			NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((totalCategory *)((TRONAppDelegate *)APPDELEGATE).totalCategoryWin).everyCate objectAtIndex:(num*7)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		else if ([[row objectAtIndex:1]intValue]==10)
		{
			num2 = [[row objectAtIndex:2]intValue];
			NSLog(@"NUMBER:%d",num);
			NSString *fullmessage=[NSString stringWithFormat:@"%@api/deal/%d/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,num2,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
			NSString *fullmessage1=[NSString stringWithFormat:@"%@",[row objectAtIndex:0]];
			NSURL *url1 = [NSURL URLWithString:fullmessage1];
			ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:url1];
			[request1 startSynchronous];
		}
		else if ([[row objectAtIndex:1]intValue]==11)
		{
			num2 = [[row objectAtIndex:2]intValue];
			NSString *fullmessage=[NSString stringWithFormat:@"%@api/deal/%d/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,num2,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
			NSString *fullmessage1=[NSString stringWithFormat:@"%@",[row objectAtIndex:0]];
			NSURL *url1 = [NSURL URLWithString:fullmessage1];
			ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:url1];
			[request1 startSynchronous];
		}
		else if ([[row objectAtIndex:1]intValue]==12)
		{
			[((totalNearby *)((TRONAppDelegate *)APPDELEGATE).totalNearbyWin).counting replaceObjectAtIndex:0 withObject:@"1"];
			num = [[row objectAtIndex:0]intValue];
			NSString *fullmessage=[NSString stringWithFormat:@"%@api/deal/%@/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((totalNearby *)((TRONAppDelegate *)APPDELEGATE).totalNearbyWin).infoNeed objectAtIndex:(num*4)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		else if ([[row objectAtIndex:1]intValue]==15)
		{
			num = [[row objectAtIndex:0]intValue];
			NSLog(@"%d",num);
			NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((category *)((TRONAppDelegate *)APPDELEGATE).categoryWin).cateArray objectAtIndex:(num*5)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		else if ([[row objectAtIndex:1]intValue]==16)
		{
			[((totalGift *)((TRONAppDelegate *)APPDELEGATE).totalGiftWin).counting replaceObjectAtIndex:0 withObject:@"1"];
			num = [[row objectAtIndex:0]intValue];
			NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((totalGift *)((TRONAppDelegate *)APPDELEGATE).totalGiftWin).everyGift objectAtIndex:(num*7)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSLog(@"full:%@",fullmessage);
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		else if ([[row objectAtIndex:1]intValue]==17)
		{
			num = [[row objectAtIndex:0]intValue];
			NSLog(@"%d",num);
			NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((giftredeem *)((TRONAppDelegate *)APPDELEGATE).giftredeemWin).giftArray objectAtIndex:(num*4)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		else {
			num = [[row objectAtIndex:0]intValue];
			[((totalMerchant *)((TRONAppDelegate *)APPDELEGATE).totalMerchantView).count replaceObjectAtIndex:0 withObject:@"1"];
			NSString *fullmessage=[NSString stringWithFormat:@"%@?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",[((totalMerchant *)((TRONAppDelegate *)APPDELEGATE).totalMerchantView).Allmerchant objectAtIndex:(num*6)],[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			dealDetail = [request responseString];
		}
		
		SBJsonParser *parse = [[SBJsonParser alloc]init];
		totalDeal = [parse objectWithString:dealDetail error:nil];
		NSLog(@"TOTAL DEAL:%@",totalDeal);
		NSString *error = [totalDeal objectForKey:@"error_code"];
		if ([error intValue]==205 || [error intValue]==100) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"Server Error! Please Login again!" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
			[alert show];
			[alert release];
			[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
		}
		else {
			allDeal = [totalDeal objectForKey:@"deal"];
			NSString *actualPrice = [allDeal objectForKey:@"actual_price"];
			NSString *dealEndDate = [allDeal objectForKey:@"deal_end_date"];
			[allDetail addObject:actualPrice];
			[allDetail addObject:dealEndDate];
			totalOutlet = [allDeal objectForKey:@"deal_outlets"];
			for (int i=0; i<[totalOutlet count]; i++) {
				outlets = [totalOutlet objectAtIndex:i];
				NSString *address = [outlets objectForKey:@"address"];
				NSLog(@"%@",address);
				NSString *outletID = [outlets objectForKey:@"id"];
				NSString *lat = [outlets objectForKey:@"latitude"];
				NSString *longt = [outlets objectForKey:@"longitude"];
				NSString *outletName = [outlets objectForKey:@"name"];
				[outletDetail addObject:address];
				[outletDetail addObject:outletID];
				[outletDetail addObject:lat];
				[outletDetail addObject:longt];
				[outletDetail addObject:outletName];
				
			}
			NSString *dealStartData = [allDeal objectForKey:@"deal_start_date"];
			NSString *dealStatus = [allDeal objectForKey:@"deal_value"];
			NSString *dealType = [allDeal objectForKey:@"deal_type"];
			NSString *description = [allDeal objectForKey:@"description"];
			NSString *discount = [allDeal objectForKey:@"discount"];
			NSString *dealID = [allDeal objectForKey:@"id"];
			NSString *notActive = [allDeal objectForKey:@"not_active_reason"];
			dealMechant = [allDeal objectForKey:@"merchant"];
			NSString *dataUrl = [dealMechant objectForKey:@"data_url"];
			NSString *merDes = [dealMechant objectForKey:@"description"];
			facebook = [dealMechant objectForKey:@"facebook_page_url"];
			NSString *merchantID = [dealMechant objectForKey:@"id"];
			NSString *logo = [allDeal objectForKey:@"deal_image_mini_url"];
			NSString *logoCom = [dealMechant objectForKey:@"logo_thumbnail_url"];
			comTel = [dealMechant objectForKey:@"company_tel"];
			comSite = [dealMechant objectForKey:@"company_website"];
			NSString *name1 = [dealMechant objectForKey:@"name"];
			twitter = [dealMechant objectForKey:@"twitter_page_url"];
			NSString *isActive = [allDeal objectForKey:@"is_active"];
			NSString *isExpire = [allDeal objectForKey:@"is_expired"];
			NSString *isLock = [allDeal objectForKey:@"is_locked"];
			NSString *isexpiringSoon = [allDeal objectForKey:@"is_expiring_soon"];
			NSString *isSellingFast = [allDeal objectForKey:@"is_selling_fast"];
			NSString *totalVou = [allDeal objectForKey:@"total_vouchers"];
			NSString *totalVouLabel = [allDeal objectForKey:@"total_vouchers_label"];
			NSString *totalVouDisplay = [allDeal objectForKey:@"total_vouchers_display"];
			NSString *redempEndDate = [allDeal objectForKey:@"redemption_end_date"];
			NSString *redempStartDate = [allDeal objectForKey:@"redemption_start_date"];
			NSString *shareURL = [allDeal objectForKey:@"share_url"];
			NSString *terms = [allDeal objectForKey:@"terms_and_condition"];
			NSString *dealHTM = [allDeal objectForKey:@"deal_details_html"];
			NSString *dealHTMiPhone = [allDeal objectForKey:@"deal_details_html_iphone"];
			NSString *dealTitle = [allDeal objectForKey:@"title"];
			NSString *vouType = [allDeal objectForKey:@"voucher_type"];
			NSString *checkOut = [allDeal objectForKey:@"checkout_url"];
			totalUser = [ allDeal objectForKey:@"applicable_user_types"];
			if ([totalUser count]>1 && [totalUser count]<3) {
				for (int i=0; i<2; i++) {
					userType = [totalUser objectAtIndex:i];
					NSString *Image = [userType objectForKey:@"logo_url"];
					[storeUser addObject:Image];
					[infinis2 setHidden:YES];
					[infinis setHidden:NO];
					[liting setHidden:NO];
				}
			}
			else if ([totalUser count]==0) {
				[liting setHidden:YES];
				[infinis setHidden:YES];
				[infinis2 setHidden:YES];
			}
			else if ([totalUser count]>2)
			{
				for (int i=0; i<3; i++) {
					userType = [totalUser objectAtIndex:i];
					NSString *Image = [userType objectForKey:@"logo_url"];
					[storeUser addObject:Image];
					[infinis2 setHidden:NO];
					[infinis setHidden:NO];
					[liting setHidden:NO];
				}
			}
			else {
				userType = [totalUser objectAtIndex:0];
				NSString *Image = [userType objectForKey:@"logo_url"];
				[storeUser addObject:Image];
				[infinis2 setHidden:YES];
				[infinis setHidden:YES];
				[liting setHidden:NO];
			}
			
			[allDetail addObject:dealStartData];
			[allDetail addObject:dealStatus];
			[allDetail addObject:dealType];
			[allDetail addObject:description];
			[allDetail addObject:dealID];
			[((sharingPage *)((TRONAppDelegate *)APPDELEGATE).sharingPageWin).addId replaceObjectAtIndex:0 withObject:dealID];
			[allDetail addObject:notActive];
			[allDetail addObject:dataUrl];
			[allDetail addObject:merDes];
			[allDetail addObject:facebook];
			[allDetail addObject:merchantID];
			[allDetail addObject:name1];
			[allDetail addObject:twitter];
			[allDetail addObject:isActive];
			[allDetail addObject:isExpire];
			[allDetail addObject:isLock];
			[allDetail addObject:isexpiringSoon];
			[allDetail addObject:isSellingFast];
			[allDetail addObject:totalVou];
			[allDetail addObject:totalVouLabel];
			[allDetail addObject:totalVouDisplay];
			[allDetail addObject:redempEndDate];
			[allDetail addObject:redempStartDate];
			[allDetail addObject:shareURL];
			[allDetail addObject:terms];
			[allDetail addObject:dealTitle];
			[allDetail addObject:vouType];
			[allDetail addObject:logo];
			[allDetail addObject:discount];
			[allDetail addObject:checkOut];
			[allDetail addObject:comSite];
			[allDetail addObject:comTel];
			[allDetail addObject:dealHTM];
			[allDetail addObject:dealHTMiPhone];
			
			NSString *fullmessage=[NSString stringWithFormat:@"%@",[allDetail objectAtIndex:28]];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
			[request startSynchronous];
			UIImage *cellImage = [UIImage imageWithData:[request responseData]];
			[image setImage:cellImage];
			[((download *)((TRONAppDelegate *)APPDELEGATE).downloadWin).LogoData replaceObjectAtIndex:0 withObject:[request responseData]];
			NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
			[inputFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss Z"];
			
			NSString *getDATE = [NSString stringWithFormat:@"%@ 00:00:00 +0000",[allDetail objectAtIndex:1]];
			NSDate *formatterDate = [inputFormatter dateFromString:getDATE];
			
			NSDate *past = [NSDate date];
			
			int i = [formatterDate timeIntervalSince1970];
			int j = [past timeIntervalSince1970];
			
			X = i-j;
			int totalDays=(int)((double)X/(3600.0*24.00));
			month = totalDays/30;
			dayLeft = totalDays%30;
			NSString *getDATE2 = [NSString stringWithFormat:@"%@ 00:00:00 +0000",[allDetail objectAtIndex:2]];
			NSDate *formatterDate2 = [inputFormatter dateFromString:getDATE2];
			
			NSDate *past1 = [NSDate date];
			
			int i2 = [formatterDate2 timeIntervalSince1970];
			int j2 = [past1 timeIntervalSince1970];
			
			double X2 = i2-j2;
			
			int totalDays2=(int)((double)X2/(3600.0*24.00));
			NSLog(@"TOTALDAYS:%d",totalDays2);
			if (totalDays2>0) {
				[dealTyped replaceObjectAtIndex:0 withObject:@"1"];
			}
			else if (totalDays2<1) {
				[dealTyped replaceObjectAtIndex:0 withObject:@"0"];
			}
			
			NSURL *url1 = [NSURL URLWithString:logoCom];
			ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:url1];
			[request1 startSynchronous];
			UIImage *cellImage1 = [UIImage imageWithData:[request1 responseData]];
			[comLogo setImage:cellImage1];
			[comName setText:name1];
			[comTelep setTitle:[NSString stringWithFormat:@"Phone %@",comTel] forState:UIControlStateNormal];
			
			if ([[allDetail objectAtIndex:27]intValue]==1) {
				[buy setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
				[nameBought setText:@"Downloads"];
				if ([[allDetail objectAtIndex:14]intValue]==0) {
					[check setHidden:YES];
					[line1 setText:[NSString stringWithFormat:@"%@",[allDetail objectAtIndex:7]]];
					[messSold setText:[NSString stringWithFormat:@"%@",[allDetail objectAtIndex:7]]];
					[messSold setHidden:NO];
					[buy setHidden:YES];
					[price setHidden:YES];
					[nameBought setHidden:NO];
					[totalBuy setHidden:NO];
					[nameValue setHidden:YES];
					[totalValue setHidden:YES];
					[totalDiscount setHidden:NO];
					[nameDis setHidden:NO];
					[mom setHidden:YES];
					[left setHidden:YES];
					[lcShow setHidden:YES];
				}
				else {
					if ([[allDetail objectAtIndex:16]intValue]==1) {
						[line1 setText:[NSString stringWithFormat:@"The deal is locked"]];
						[check setHidden:YES];
					}
					else {
						[check setHidden:NO];
					}
					[messSold setHidden:YES];
					[price setHidden:YES];
					[line1 setHidden:NO];
					[nameBought setHidden:NO];
					[totalBuy setHidden:NO];
					[nameValue setHidden:YES];
					[totalValue setHidden:YES];
					[totalDiscount setHidden:NO];
					[nameDis setHidden:NO];
					[mom setHidden:NO];
					[left setHidden:NO];
					[lcShow setHidden:YES];
				}
				
			}
			else if ([[allDetail objectAtIndex:27]intValue]==2){
				[buy setImage:[UIImage imageNamed:@"buybutton.png"] forState:UIControlStateNormal];
				[nameBought setText:@"Sold"];
				if ([[allDetail objectAtIndex:14]intValue]==0) {
					[check setHidden:YES];
					[line1 setText:[NSString stringWithFormat:@"%@",[allDetail objectAtIndex:7]]];
					[messSold setText:[NSString stringWithFormat:@"%@",[allDetail objectAtIndex:7]]];
					[messSold setHidden:NO];
					[buy setHidden:YES];
					[nameBought setHidden:NO];
					[totalBuy setHidden:NO];
					[nameValue setHidden:NO];
					[totalValue setHidden:NO];
					[totalDiscount setHidden:YES];
					[nameDis setHidden:YES];
					[mom setHidden:YES];
					[left setHidden:YES];
					[lcShow setHidden:YES];
					[price setHidden:NO];
				}
				else {
					if ([[allDetail objectAtIndex:16]intValue]==1) {
						[line1 setText:[NSString stringWithFormat:@"The deal is locked"]];
						[check setHidden:YES];
					}
					else {
						[check setHidden:NO];
					}
					[messSold setHidden:YES];
					[line1 setHidden:NO];
					[nameBought setHidden:NO];
					[totalBuy setHidden:NO];
					[nameValue setHidden:NO];
					[totalValue setHidden:NO];
					[totalDiscount setHidden:YES];
					[nameDis setHidden:YES];
					[mom setHidden:NO];
					[left setHidden:NO];
					[lcShow setHidden:YES];
					[price setHidden:NO];
				}
			}
			else if ([[allDetail objectAtIndex:27]intValue]==3){
				[buy setImage:[UIImage imageNamed:@"redeem.png"] forState:UIControlStateNormal];
				if ([[allDetail objectAtIndex:14]intValue]==0) {
					[check setHidden:YES];
					[line1 setText:[NSString stringWithFormat:@"%@",[allDetail objectAtIndex:7]]];
					[messSold setText:[NSString stringWithFormat:@"%@",[allDetail objectAtIndex:7]]];
					[messSold setHidden:NO];
					[buy setHidden:YES];
					[nameBought setHidden:NO];
					[totalBuy setHidden:NO];
					[nameValue setHidden:NO];
					[totalValue setHidden:NO];
					[totalDiscount setHidden:YES];
					[nameDis setHidden:YES];
					[mom setHidden:YES];
					[left setHidden:YES];
					[lcShow setHidden:YES];
					[price setHidden:NO];
				}
				else {
					if ([[allDetail objectAtIndex:16]intValue]==1) {
						[line1 setText:[NSString stringWithFormat:@"The deal is locked"]];
						[check setHidden:YES];
					}
					else {
						[check setHidden:NO];
					}
					[messSold setHidden:YES];
					[line1 setHidden:NO];
					[nameBought setHidden:NO];
					[totalBuy setHidden:NO];
					[nameValue setHidden:NO];
					[totalValue setHidden:NO];
					[totalDiscount setHidden:YES];
					[nameDis setHidden:YES];
					[mom setHidden:NO];
					[left setHidden:NO];
					[lcShow setHidden:YES];
					[price setHidden:NO];
				}

			}
			else if ([[allDetail objectAtIndex:27]intValue]==0){
				[check setHidden:YES];
				[buy setHidden:YES];
				[price setHidden:YES];
				[line1 setHidden:YES];
				[nameBought setHidden:YES];
				[totalBuy setHidden:YES];
				[nameValue setHidden:YES];
				[totalValue setHidden:YES];
				[totalDiscount setHidden:YES];
				[nameDis setHidden:YES];
				[mom setHidden:NO];
				[left setHidden:NO];
				[lcShow setHidden:NO];
			}
			if (month>0 && month<2) {
				[mom setText:[NSString stringWithFormat:@"%d month",month]];
			}
			else if (month==0){
				if (dayLeft>7 && dayLeft<15) {
					[mom setText:@"About 1 week"];
				}
				else if (dayLeft>14 && dayLeft<22) {
					[mom setText:@"About 2 week"];
				}
				else if (dayLeft>21 && dayLeft<32) {
					[mom setText:@"About 3 week"];
				}
			}
			else if (dayLeft<0) {
				[mom setText:@"0 day"];
				[buy setHidden:YES];
			}
			else if (month>1){
				[mom setText:[NSString stringWithFormat:@"%d months",month]];
			}
			
			if ([[allDetail objectAtIndex:27]intValue]==3) {
				NSString *priceSet = [NSString stringWithFormat:@"%@ Points",[allDetail objectAtIndex:3]];
				[price setText:priceSet];
			}
			else {
				NSString *priceSet = [NSString stringWithFormat:@"RM %@",[allDetail objectAtIndex:3]];
				[price setText:priceSet];
			}
			NSString *nameSet = [NSString stringWithFormat:@"%@",[allDetail objectAtIndex:12]];
			((TRONAppDelegate *)APPDELEGATE).navBar.navigationBar.topItem.title=nameSet;
			NSString *titleSet = [NSString stringWithFormat:@"%@",[allDetail objectAtIndex:26]];
			[describe setText:titleSet];
			if ([describe.text length] > 220) {
				[describe setFont:[UIFont boldSystemFontOfSize:8]];
			}
			else if ([describe.text length] > 150) {
				[describe setFont:[UIFont boldSystemFontOfSize:10]];
			}
			else if ([describe.text length] > 100) {
				[describe setFont:[UIFont boldSystemFontOfSize:12]];
			}
			else {
				[describe setFont:[UIFont boldSystemFontOfSize:15]];
			}

			
			for (int i=0; i<[storeUser count]; i++)
			{
				NSString *fullmessage=[NSString stringWithFormat:@"%@",[storeUser objectAtIndex:i]];
				NSURL *url = [NSURL URLWithString:fullmessage];
				ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
				[request startSynchronous];
				if (i==0) {
					[liting setImage:[UIImage imageWithData:[request responseData]]];
				}
				else if(i==1){
					[infinis setImage:[UIImage imageWithData:[request responseData]]];
				}
				else {
					[infinis2 setImage:[UIImage imageWithData:[request responseData]]];
				}

			}
			CGRect frame1 = describe.frame;
			frame1.size.height= describe.contentSize.height;
			//describe.frame1=frame1;
			if (describe.contentSize.height>36) {
				[describe setFrame:CGRectMake(10, 41, 300, 66)];
			}
			else {
				[describe setFrame:CGRectMake(10, 54, 300, 66)];
			}

			NSString *totalBuySet = [NSString stringWithFormat:@"%@",[allDetail objectAtIndex:21]];
			if ([totalBuySet isEqual:@"0 Downloads"] || [totalBuySet isEqual:@"0 Downloaded"] || [totalBuySet isEqual:@"0 Sold"] || [totalBuySet isEqual:@"0 Redeemed"]) {
				[totalBuy setText:@"Be the First!"];
			}
			else {
				[totalBuy setText:totalBuySet];
			}
			NSString *totalActualPrice = [NSString stringWithFormat:@"RM%@",[allDetail objectAtIndex:0]];
			[totalValue setText:totalActualPrice];
			NSString *totalDiscountSet = [NSString stringWithFormat:@"%@%",[allDetail objectAtIndex:29]];
			[totalDiscount setText:totalDiscountSet];
			NSString *totalSaveSet = [NSString stringWithFormat:@"RM%d",[[allDetail objectAtIndex:0]intValue]-[[allDetail objectAtIndex:3]intValue]];
			[totalSave setText:totalSaveSet];
						NSString *red = [NSString stringWithFormat:@"%@",[allDetail objectAtIndex:23]];
			[redeem setText:red];
			loaded.hidden=YES;
			[run stopAnimating];
			loaded2.hidden=YES;
			[run2 stopAnimating];
			[blur setHidden:YES];
			[outlet setHidden:NO];
            [comSite2 setHidden:YES];
            [comTelep setHidden:YES];
            [comFace setHidden:YES];
            [comTwi setHidden:YES];
            [comLogo setHidden:YES];
            [comName setHidden:YES];
			[self performSelector:@selector(solution2) withObject:nil afterDelay:0.2];
		}
	}
	@catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"Finall-Deal");
	}

}

-(void) updateCountdown
{
	int hours, minutes, seconds, daysss;
	if (month==0) {
		if (dayLeft<=7) {
			X--;
			if (X>0) {
				int totalDays=(int)((double)X/(3600.0*24.00));
				daysss = totalDays%30;
				if (daysss>0) {
					int realHour = daysss*24;
					hours = (X/3600)-realHour;
					if ((hours-8)<0) {
						hours = hours+24;
						daysss = daysss-1;
					}
					minutes = (X % 3600) / 60;
					seconds = (X % 3600) % 60;
				}
				else {
					hours = X/3600;
					minutes = (X % 3600) / 60;
					seconds = (X % 3600) % 60;
				}
				mom.text = [NSString stringWithFormat:@"%dd %02dh %02dm %02ds", daysss, hours-8, minutes+1, seconds];
			}
			else {
				[mom setHidden:YES];
				[left setHidden:YES];
				[messSold setText:@"SOLD OUT"];
				//[messSold setText:[NSString stringWithFormat:@"%@",[allDetail objectAtIndex:7]]];
				[messSold setHidden:NO];
				[buy setHidden:YES];
			}

		}
	}
    //hours = secondsLeft / 3600;
    //minutes = (secondsLeft % 3600) / 60;
    //seconds = (secondsLeft %3600) % 60;
   // cD.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[comTelep setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
	[self.ground.layer setBorderColor:[[UIColor grayColor] CGColor]];
    //[self.ground.layer setBorderWidth:1.0];
	[self.ground.layer setCornerRadius:8.0];
	[self.ground.layer setMasksToBounds:YES];
    self.ground.clipsToBounds = YES;
	[self.ground2.layer setBorderColor:[[UIColor grayColor] CGColor]];
    //[self.ground2.layer setBorderWidth:1.0];
	[self.ground2.layer setCornerRadius:8.0];
	[self.ground2.layer setMasksToBounds:YES];
    self.ground2.clipsToBounds = YES;
	scroll.contentSize=CGSizeMake(320, 840);
	allDetail=[[NSMutableArray alloc]init];
	row=[[NSMutableArray alloc]init];
	[row addObject:@""];
	[row addObject:@"0"];
	[row addObject:@""];
	outletDetail = [[NSMutableArray alloc]init];
	dealTyped = [[NSMutableArray alloc]init];
	[dealTyped addObject:@""];
	storeUser = [[NSMutableArray alloc]init];
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
	[blur setHidden:NO];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	self.highlight2.delegate = nil;
    [highlight2 stopLoading];
    [highlight2 release];
	[allDetail release];
	[storeUser release];
	[row release];
	[outletDetail release];
	[dealTyped release];
	[image release];
	[run release];
	[totalBuy release];
	[totalDiscount release];
	[totalValue release];
	[totalSave release];
	[price release];
	[name release];
	[loaded release];
	[nameBought release];
	[nameDis release];
	[nameValue release];
	[nameSave release];
	[redeem release];
	[username release];
	[outletDetail release];
	[ground release];
	[ground2 release];
    [super dealloc];
}


@end
