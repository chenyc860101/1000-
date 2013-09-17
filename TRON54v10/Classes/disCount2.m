//
//  disCount2.m
//  TRON
//
//  Created by Wu Ming on 5/4/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "disCount2.h"


@implementation disCount2
@synthesize discount2Array,discount2Deal,discount2Array2;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Tells that the row is selected
	NSInteger row=[indexPath row];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",row]];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:1 withObject:@"6"];
	[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).dealWin animated:YES];
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).run startAnimating];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).loaded setHidden:NO];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dealCell"];
	if(cell==nil){
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"dealCell" owner:self options:nil];
		cell = (UITableViewCell *)[nib objectAtIndex:0];
	}
	NSInteger row=[indexPath row];
	if ([[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).currentUserType objectAtIndex:0]intValue]==0) {
		[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[discount2Array objectAtIndex:(row*10)+9]]];
		[((UILabel *)[cell viewWithTag:2]) setText:[discount2Array objectAtIndex:(row*10)+7]];
		[((UITextView *)[cell viewWithTag:3]) setText:[discount2Array objectAtIndex:(row*10)+8]];
		if ([[discount2Array objectAtIndex:(row*10)+3]intValue]==1) {
			[((UILabel *)[cell viewWithTag:4]) setHidden:NO];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:NO];
		}
		else {
			[((UILabel *)[cell viewWithTag:4]) setHidden:YES];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:YES];
		}
	}
	else {
		[((UIImageView *)[cell viewWithTag:1]) setImage:[UIImage imageWithData:[discount2Array2 objectAtIndex:(row*9)+8]]];
		[((UILabel *)[cell viewWithTag:2]) setText:[discount2Array2 objectAtIndex:(row*9)+6]];
		[((UITextView *)[cell viewWithTag:3]) setText:[discount2Array2 objectAtIndex:(row*9)+7]];
		if ([[discount2Array2 objectAtIndex:(row*9)+1]intValue]==1) {
			[((UILabel *)[cell viewWithTag:4]) setHidden:NO];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:NO];
		}
		else {
			[((UILabel *)[cell viewWithTag:4]) setHidden:YES];
			[((UIImageView *)[cell viewWithTag:5]) setHidden:YES];
		}
	}

	
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
	discount2Array = [[NSMutableArray alloc]init];
	discount2Array2 = [[NSMutableArray alloc]init];
	if ([[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).currentUserType objectAtIndex:0]intValue]==0) {
		for (int i=0; i<[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray count]/9; i++) {
			if ([[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray objectAtIndex:(i*9)+2]intValue]==2) {
				[discount2Array addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray objectAtIndex:(i*9)]];
				[discount2Array addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray objectAtIndex:(i*9)+1]];
				[discount2Array addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray objectAtIndex:(i*9)+2]];
				[discount2Array addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray objectAtIndex:(i*9)+3]];
				[discount2Array addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray objectAtIndex:(i*9)+4]];
				[discount2Array addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray objectAtIndex:(i*9)+5]];
				[discount2Array addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray objectAtIndex:(i*9)+6]];
				[discount2Array addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray objectAtIndex:(i*9)+7]];
				[discount2Array addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularArray objectAtIndex:(i*9)+8]];
				[discount2Array addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).popularImage objectAtIndex:(i)]];
			}
		}
			return [discount2Array count]/10;
	}
	else {
		for (int i=0; i<[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendArray count]/8; i++) {
			if ([[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendArray objectAtIndex:(i*8)+2]intValue]==2) {
				[discount2Array2 addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendArray objectAtIndex:(i*8)]];
				[discount2Array2 addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendArray objectAtIndex:(i*8)+1]];
				[discount2Array2 addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendArray objectAtIndex:(i*8)+2]];
				[discount2Array2 addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendArray objectAtIndex:(i*8)+3]];
				[discount2Array2 addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendArray objectAtIndex:(i*8)+4]];
				[discount2Array2 addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendArray objectAtIndex:(i*8)+5]];
				[discount2Array2 addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendArray objectAtIndex:(i*8)+6]];
				[discount2Array2 addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendArray objectAtIndex:(i*8)+7]];
				[discount2Array2 addObject:[((popular *)((TRONAppDelegate *)APPDELEGATE).popularWin).recommendImage objectAtIndex:(i)]];
			}
		}
			return [discount2Array2 count]/9;
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
