//
//  vouchers.m
//  TRON
//
//  Created by Wu Ming on 4/2/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "vouchers.h"


@implementation vouchers
@synthesize allVourcher,Vourcher;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		NSLog(@"HIHIHI");
    }
    return self;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if(cell==nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"any-cell"] autorelease];
	}
	UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(12, 75, 100, 15)];
	label.backgroundColor=[UIColor clearColor];
	label.text=@"Vouchers No";
	label.font=[UIFont fontWithName:@"Arial" size:12];
	NSInteger row=[indexPath row];
	cell.textLabel.text = @"test";
	cell.detailTextLabel.text = @"A";
	cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
	[cell addSubview:label];
	//Cell for Row
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//Row for Section
	allVourcher = [[NSMutableArray alloc]init];
	return [allVourcher count];
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
