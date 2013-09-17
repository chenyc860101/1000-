//
//  category.h
//  TRON
//
//  Created by Wu Ming on 5/4/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRONAppDelegate.h"
#import "totalCategory.h"


@interface category : UIViewController <UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate,UISearchBarDelegate,UIAlertViewDelegate>{
	int count,counting;
	NSDictionary *allCategory,*categoryData,*searchCategory,*finalSearch,*merchant;
	NSArray *categoryDeal,*searchAnwer;
	IBOutlet UITableView *categoryMain;
	NSMutableArray *cateArray,*picCate;
	IBOutlet UIActivityIndicatorView *loadAni;
	IBOutlet UILabel *loadtext;
	IBOutlet UISearchBar *searching;
}
@property (nonatomic,retain) NSMutableArray *cateArray,*picCate;;
@property (nonatomic,retain) UISearchBar *searching;
@property int counting,count;
-(IBAction)refreshCate:(id)sender;
@end
