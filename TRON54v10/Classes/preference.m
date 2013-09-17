//
//  preference.m
//  TRON
//
//  Created by Wu Ming on 4/6/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "preference.h"


@implementation preference
@synthesize getCateData,save,checkmark,check;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}
-(IBAction)saveAction
{
	NSString *fullmessage=[NSString stringWithFormat:@"%@api/user/info/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0]];
	NSURL *url = [NSURL URLWithString:fullmessage];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	for (int i=0; i<[checkmark count]; i++) {
		if ([[checkmark objectAtIndex:i]isEqual:@"True"]) {
			[request addPostValue:[NSString stringWithFormat:@"%@",[checkmark objectAtIndex:i]] forKey:[NSString stringWithFormat:@"%@",[getCateData objectAtIndex:(i*3)]]];
		}
	}
	[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
	[request setDelegate:self];
	[request startAsynchronous];
	[save setHidden:YES];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
	switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
		case 0:
		{
			NSString *allAccount = [request responseString];
			SBJsonParser *parse = [[SBJsonParser alloc]init];
			accDetail = [parse objectWithString:allAccount error:nil];
			NSLog(@"ACCDETAIL:%@",accDetail);
			prefer = [accDetail objectForKey:@"preferences"];
			for (int i=0; i<[prefer count]; i++) {
				prefreData = [prefer objectAtIndex:i];
				NSString *preselect = [prefreData objectForKey:@"selected"];
				[getCateData replaceObjectAtIndex:(i*3)+2 withObject:preselect];
			}
			break;
		}
	}
	[check reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSArray *sectionInfo = [[NSArray alloc]initWithObjects:@"I am interested with",nil];
	return [sectionInfo objectAtIndex:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if(cell==nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"any-cell"] autorelease];
	}
	NSInteger row = indexPath.row;
		cell.text=[getCateData objectAtIndex:(row*3)+1];
		if ([[getCateData objectAtIndex:(row*3)+2]intValue]==1) {
			cell.accessoryType=UITableViewCellAccessoryCheckmark;
		}
		else {
			cell.accessoryType=UITableViewCellAccessoryNone;
		}
	return	cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger new=[indexPath row];
	NSInteger select = new;
	[save setHidden:NO];
	UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
	if ([[checkmark objectAtIndex:new]isEqual:@"True"]) {
		newCell.accessoryType=UITableViewCellAccessoryNone;
		[checkmark replaceObjectAtIndex:new withObject:@"False"];
	}
	else {
		newCell.accessoryType=UITableViewCellAccessoryCheckmark;
		[checkmark replaceObjectAtIndex:new withObject:@"True"];
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//Row for Section
	checkmark = [[NSMutableArray alloc]init];
	if ([getCateData count]/3==0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TRON Notification" message:@"Category is empty for now! Please click on categories" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else {
		for (int i=0; i<[getCateData count]/3; i++) {
			if ([[getCateData objectAtIndex:(i*3)+2]intValue]==1) {
				[checkmark addObject:@"True"];
			}
			else {
				[checkmark addObject:@"False"];
			}
		}
	}
	return [getCateData count]/3;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[checkmark release];
    [super dealloc];
}


@end
