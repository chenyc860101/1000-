    //
//  loginMain.m
//  TRON
//
//  Created by Wu Ming on 3/30/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "loginMain.h"


@implementation loginMain
@synthesize login,guest,button,userInput,userFinal,acc,userAcc;


-(IBAction)goMain:(id)sender
{
	@try {
		[loading startAnimating];
		[load setHidden:NO];
		tag= [sender tag];
		[self performSelector:@selector(loginLoad:) withObject:nil afterDelay:0.1];
		[sender resignFirstResponder];
	}
	@catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"finally-login");
	}
}
-(void)loginLoad:(UIButton *)sender
{
	[userFinal removeAllObjects];
	if ([[userInput objectAtIndex:0]isEqual:@""] || [[userInput objectAtIndex:1]isEqual:@""]) {
		if (tag==1) {
			[userFinal removeAllObjects];
            [userInput replaceObjectAtIndex:2 withObject:@"1"];
			NSString *fullmessage=[NSString stringWithFormat:@"%@api/login/",SERVER];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
			[request addPostValue:@"guest" forKey:@"username"];
			[request addPostValue:@"guest" forKey:@"password"];
			[request addPostValue:@"" forKey:@"loginKey"];
			[request addPostValue:@"bdd2279f-ba2b-4c78-816b-1d438037461b" forKey:@"apiKey"];
			[request startSynchronous];
			
			NSError *error = [request error];
			if (error) {
				UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Internet Connection" message:@"It appears that you might not have an internet connection. Please make sure your 3G/WIFI is switched on." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
				[alert show];
				[alert release];
				[load setHidden:YES];
				[loading stopAnimating];
			}
			if (!error) {
				NSString *featured = [request responseString];
				
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				list = [parse objectWithString:featured error:nil];
				NSLog(@"ttt:%@",list);
				NSString *logKey = [list objectForKey:@"loginKey"];
				NSString *success = [list objectForKey:@"success"];
				[userFinal addObject:logKey];
				[userFinal addObject:success];
				user = [list objectForKey:@"user"];
				if ([user count]>1) {
					NSString *userId = [user objectForKey:@"id"];
					NSString *name = [user objectForKey:@"name"];
					
					[userFinal addObject:userId];
					[userFinal addObject:name];
				}
				
				if ([[userFinal objectAtIndex:1]intValue]==1) {
					[((TRONAppDelegate *)APPDELEGATE).TABBAR setSelectedItem:[[((TRONAppDelegate *)APPDELEGATE).TABBAR items] objectAtIndex:0]];
					[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).featureWin animated:YES];
					[((TRONAppDelegate *)APPDELEGATE).TABBAR setHidden:NO];
					[load setHidden:YES];
					[loading stopAnimating];
					button = [[NSArray alloc]initWithObjects:@"0",nil];
					tPass.text=@"";
					NSLog(@"%@",button);
				}
				else {
					[load setHidden:YES];
					[loading stopAnimating];
					UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"WARNING" 
																   message:@"The username or password you entered is incorrect!" 
																  delegate:self 
														 cancelButtonTitle:@"DISMISS" 
														 otherButtonTitles:nil];
					[alert show];
					[alert release];
				}

			}					
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"WARNING" 
														   message:@"It appears that one of the required information is not entered. Please enter a username and a password to login" 
														  delegate:self 
												 cancelButtonTitle:@"DISMISS" 
												 otherButtonTitles:nil];
			[alert show];
			[alert release];
			[load setHidden:YES];
			[loading stopAnimating];
		}
	}
	else {
		
		if (tag==1) {
			[userFinal removeAllObjects];
            [userInput replaceObjectAtIndex:2 withObject:@"1"];
			NSString *fullmessage=[NSString stringWithFormat:@"%@api/login/",SERVER];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
			[request addPostValue:@"guest" forKey:@"username"];
			[request addPostValue:@"guest" forKey:@"password"];
			[request addPostValue:@"" forKey:@"loginKey"];
			[request addPostValue:@"bdd2279f-ba2b-4c78-816b-1d438037461b" forKey:@"apiKey"];
			[request startSynchronous];
			
			NSError *error = [request error];
			if (error) {
				UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Internet Connection" message:@"It appears that you might not have an internet connection. Please make sure your 3G/WIFI is switched on." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
				[alert show];
				[alert release];
				[load setHidden:YES];
				[loading stopAnimating];
			}
			if (!error) {
				NSString *featured = [request responseString];
				
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				list = [parse objectWithString:featured error:nil];
				NSLog(@"ttt%@",list);
				NSString *logKey = [list objectForKey:@"loginKey"];
				NSString *success = [list objectForKey:@"success"];
				[userFinal addObject:logKey];
				[userFinal addObject:success];
				user = [list objectForKey:@"user"];
				if ([user count]>1) {
					NSString *userId = [user objectForKey:@"id"];
					NSString *name = [user objectForKey:@"name"];
					
					[userFinal addObject:userId];
					[userFinal addObject:name];
				}
				
				if ([[userFinal objectAtIndex:1]intValue]==1) {
					[((TRONAppDelegate *)APPDELEGATE).TABBAR setSelectedItem:[[((TRONAppDelegate *)APPDELEGATE).TABBAR items] objectAtIndex:0]];
					[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).featureWin animated:YES];
					[((TRONAppDelegate *)APPDELEGATE).TABBAR setHidden:NO];
					[load setHidden:YES];
					[loading stopAnimating];
					button = [[NSArray alloc]initWithObjects:@"0",nil];
					tPass.text=@"";
					NSLog(@"%@",button);
				}
				else {
					[load setHidden:YES];
					[loading stopAnimating];
					UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"WARNING" 
																   message:@"The username or password you entered is incorrect!" 
																  delegate:self 
														 cancelButtonTitle:@"DISMISS" 
														 otherButtonTitles:nil];
					[alert show];
					[alert release];
				}
			}					
		}
		else {
            [userInput replaceObjectAtIndex:2 withObject:@"0"];
			NSString *fullmessage=[NSString stringWithFormat:@"%@api/login/",SERVER];
			NSURL *url = [NSURL URLWithString:fullmessage];
			ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
			[request addPostValue:[userInput objectAtIndex:0] forKey:@"username"];
			[request addPostValue:[userInput objectAtIndex:1] forKey:@"password"];
			[request addPostValue:@"" forKey:@"loginKey"];
			[request addPostValue:@"bdd2279f-ba2b-4c78-816b-1d438037461b" forKey:@"apiKey"];
			[request startSynchronous];
			
			NSError *error = [request error];
			if (error) {
				UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Internet Connection" message:@"It appears that you might not have an internet connection. Please make sure your 3G/WIFI is switched on." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
				[alert show];
				[alert release];
				[load setHidden:YES];
				[loading stopAnimating];
			}
			if (!error) {
				NSString *featured = [request responseString];
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				list = [parse objectWithString:featured error:nil];
				NSLog(@"ttt%@",list);
				NSString *logKey = [list objectForKey:@"loginKey"];
				NSString *success = [list objectForKey:@"success"];
                NSString *errorMess = [list objectForKey:@"error_message"];
				[userFinal addObject:logKey];
				[userFinal addObject:success];
				user = [list objectForKey:@"user"];
				if ([user count]>1) {
					NSString *userId = [user objectForKey:@"id"];
					NSString *name = [user objectForKey:@"name"];
					
					[userFinal addObject:userId];
					[userFinal addObject:name];
				}
				if ([[userFinal objectAtIndex:1]intValue]==1) {
					[((TRONAppDelegate *)APPDELEGATE).TABBAR setSelectedItem:[[((TRONAppDelegate *)APPDELEGATE).TABBAR items] objectAtIndex:0]];
					[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).featureWin animated:YES];
					[((TRONAppDelegate *)APPDELEGATE).TABBAR setHidden:NO];
					[load setHidden:YES];
					[loading stopAnimating];
					button = [[NSArray alloc]initWithObjects:@"0",nil];
					tPass.text=@"";
					NSLog(@"%@",button);
				}
				else {
					[load setHidden:YES];
					[loading stopAnimating];
					UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"WARNING" 
																   message:errorMess 
																  delegate:self 
														 cancelButtonTitle:@"DISMISS" 
														 otherButtonTitles:nil];
					[alert show];
					[alert release];
				}
				
			}
			
			
		}

	}
}
-(IBAction)goMain3:(id)sender
{
	if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/message.txt",DOCUMENT]]) {
		acc=[[NSMutableArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/message.txt",DOCUMENT]]];
		NSLog(@"ACC:%@",acc);
		myAlertView = [[UIAlertView alloc] initWithTitle:@"Please enter your password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
		myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
		[myTextField setSecureTextEntry:YES];
		[myTextField setTag:5];
		myTextField.delegate=self;
		myTextField.returnKeyType=UIReturnKeyDone;
		[myTextField becomeFirstResponder];
		[myTextField setBackgroundColor:[UIColor whiteColor]];
		[myAlertView setTransform:CGAffineTransformMakeTranslation(0,60)];
		[myAlertView addSubview:myTextField];
		[myAlertView show];
		[myAlertView release];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Not Account Exist" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	UITextField* myField = (UITextField*)[alertView viewWithTag:5];
	if (buttonIndex==1) {
		[((account *)((TRONAppDelegate *)APPDELEGATE).accWin).counting replaceObjectAtIndex:0 withObject:@"2"];
		NSString *MD5String = [Utilities returnMD5Hash:[NSString stringWithFormat:@"%@",myField.text]];
		NSString *MD5String2 = [Utilities returnMD5Hash:[NSString stringWithFormat:@"%@",[acc objectAtIndex:6]]];
		NSLog(@"%@",myField.text);
		NSLog(@"1st%@",MD5String);
		NSLog(@"2nd%@",MD5String2);
		if ([MD5String2 isEqual:MD5String]) {
			[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).accWin]];
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"Wrong Password" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField.tag==1) {
		[textField resignFirstResponder];
	}
	else if (textField.tag==0) {
		[textField addTarget:self action:@selector(goMain:) forControlEvents:UIControlEventEditingDidEndOnExit];
	}
	else if (textField.tag==5) {
		[myAlertView resignFirstResponder];
		[myTextField resignFirstResponder];
	}
	return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
	if ([textField tag]==1) {
		[userInput replaceObjectAtIndex:0 withObject:textField.text];
		NSLog(@"You are email");
	}
	else if	([textField tag]==0 && textField.text!=nil)
	{
		[userInput replaceObjectAtIndex:1 withObject:textField.text];
		NSLog(@"You are password");
	}
	//NSLog(@"%@",tUser.text);
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
	[super viewWillAppear:YES];
	[((TRONAppDelegate *)APPDELEGATE).TABBAR setHidden:YES];
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:YES animated:YES];
	[userFinal removeAllObjects];
	
	[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).currCount2 replaceObjectAtIndex:0 withObject:@"0"];
	[((featured *)((TRONAppDelegate *)APPDELEGATE).featureWin).count replaceObjectAtIndex:0 withObject:@"0"];
	[((featured *)((TRONAppDelegate *)APPDELEGATE).featureWin).featureTable reloadData];
	[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userInput replaceObjectAtIndex:1 withObject:@""];
	[((account *)((TRONAppDelegate *)APPDELEGATE).accWin).counting replaceObjectAtIndex:0 withObject:@"0"];
	[((nearBy *)((TRONAppDelegate *)APPDELEGATE).nearWin).counting replaceObjectAtIndex:0 withObject:@"0"];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[((TRONAppDelegate *)APPDELEGATE).TABBAR setHidden:YES];
	userFinal = [[NSMutableArray alloc]init];
	userInput = [[NSMutableArray alloc]init];
	[userInput addObject:@""];
	[userInput addObject:@""];
    [userInput addObject:@"0"];
	userAcc = [[NSMutableArray alloc]init];
	[userAcc addObject:@""];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	tableView.backgroundColor=[UIColor clearColor];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if(cell==nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"any-cell"] autorelease];
	}
	[cell setSelectionStyle:UITableViewCellStyleDefault];
	tUser = [[UITextField alloc] initWithFrame:CGRectMake(110, 12, 185, 30)];
    tUser.adjustsFontSizeToFitWidth = YES;
	tUser.delegate=self;
	tUser.autocapitalizationType=NO;
	tUser.autocorrectionType=NO;
	tUser.keyboardType=UIKeyboardTypeNumberPad;
	tUser.placeholder=@"Enter Tron ID";
	tUser.tag=1;
	tUser.clearButtonMode = UITextFieldViewModeAlways;
    tUser.textColor = [UIColor blackColor];
	
    tPass = [[UITextField alloc] initWithFrame:CGRectMake(110, 11, 185, 30)];
    tPass.adjustsFontSizeToFitWidth = YES;
	tPass.delegate=self;
	tPass.returnKeyType=UIReturnKeyGo;
	tPass.placeholder=@"Enter Password";
	tPass.tag=0;
	[tPass setSecureTextEntry:YES];
    tPass.textColor = [UIColor blackColor];
	NSInteger row = [indexPath row];

	if (row==0) {
		cell.text=@"Tron ID";
		[cell addSubview:tUser];
	}
	else if(row==1)
	{
		cell.text=@"Password";
		[cell addSubview:tPass];
	}
	//Cell for Row
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//Row for Section
	return 2;
}


- (void)dealloc {
	[userFinal release];
	[userInput release];
	[userAcc release];
	[login release];
	[guest release];
	[button release];
	[acc release];
    [super dealloc];
}


@end
