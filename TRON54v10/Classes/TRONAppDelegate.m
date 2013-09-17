//
//  TRONAppDelegate.m
//  TRON
//
//  Created by Wu Ming on 3/22/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "TRONAppDelegate.h"

@implementation TRONAppDelegate

@synthesize window;
@synthesize navBar,featureWin,TABBAR,nearWin,dealWin,downloadWin,loginWin,accWin,voucherVw,settingVw,preferenceVw,totalMerchantView,discountVw,cashVw,giftVw,popularWin,discount2Vw,cash2Vw,gift2Vw,categoryWin,totalCategoryWin,accountDetailWin,totalNearbyWin,showAddressWin,showMapWin,comfirmWin,hotWin,voudealWin,sharingPageWin,settingWin,giftredeemWin,totalGiftWin,device;


#pragma mark -
#pragma mark Application lifecycle

NSString *machineName()
{
    struct utsname systemInfo;
    uname(&systemInfo);
	NSLog(@"--%@",uname(&systemInfo));
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after application launch.
	sleep(1);
    navBar=[[UINavigationController alloc]init];
	[navBar pushViewController:loginWin animated:YES];
	navBar.navigationBar.tintColor=[UIColor colorWithRed:0/255.0f green:190/255.0f blue:13/255.0f alpha:1.0f];
	[navBar setNavigationBarHidden:YES];
	device = [[NSMutableArray alloc]init];
	[device addObject:[NSString stringWithFormat:@"%@",machineName()]];
	[TABBAR setSelectedItem:[[TABBAR items]objectAtIndex:0]];
	[window addSubview:navBar.view];
	[window bringSubviewToFront:TABBAR];
    [self.window makeKeyAndVisible];

    return YES;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
	switch (item.tag) {
		case 0:
			[navBar setViewControllers:[NSArray arrayWithObject:featureWin]];
            self.navBar.title=@"";
			break;
		case 1:
            [navBar setViewControllers:[NSArray arrayWithObject:nearWin]];
			break;
		case 2:

			[navBar setViewControllers:[NSArray arrayWithObject:popularWin]];
			break;
		case 3:
			[navBar setViewControllers:[NSArray arrayWithObject:categoryWin]];
			break;
		case 4:
		{
			if ([[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).button objectAtIndex:0]intValue]==0 ) {
				[navBar setViewControllers:[NSArray arrayWithObject:accWin]];
			}
			else {
				[TABBAR setHidden:YES];
				[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userInput replaceObjectAtIndex:1 withObject:@""];
				[navBar setNavigationBarHidden:YES];
				[navBar setViewControllers:[NSArray arrayWithObject:loginWin]];
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TRON Notification" message:@"Please login to view account." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
				[alert show];
				[alert release];
			}
			break;
		}
		default:
			break;
	}
}
- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
	[navBar release];
	[device release];
	[featureWin release];
	[TABBAR release];
	[nearWin release];
	[dealWin release];
	[downloadWin release];
	[loginWin release];
	[accWin release];
	[preferenceVw release];
	[totalMerchantView release];
	[discount2Vw release];
	[gift2Vw release];
	[cash2Vw release];
	[categoryWin release];
	[totalCategoryWin release];
	[accountDetailWin release];
	[totalNearbyWin release];
	[showMapWin release];
	[comfirmWin release];
	[hotWin release];
	[voudealWin release];
	[sharingPageWin release];
	[settingWin release];
	[giftredeemWin release];
    [super dealloc];
}


@end
