    //
//  nearBy.m
//  TRON
//
//  Created by Wu Ming on 3/23/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "nearBy.h"
#import "MyPlacemark.h"

@implementation nearBy
@synthesize mapV,mapDetail,counting,mapDetail2,getCurrentLocation;

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
-(IBAction)refreshData
{
	[mapV removeAnnotations:mapV.annotations];
	b=0;
	[showRef setEnabled:NO];
	countAgain=0;
	[mapButtonTag removeAllObjects];
	[mapDetail removeAllObjects];
	[mapDetail2 removeAllObjects];
	[testing removeAllObjects];
	[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:YES];
	//[getCurrentLocation replaceObjectAtIndex:0 withObject:@"3.0635"];
	//[getCurrentLocation replaceObjectAtIndex:1 withObject:@"101.6979"];
	NSString *fullmessage=[NSString stringWithFormat:@"%@api/deal/featured/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b&latlong=%@,%@&km=5",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0],[getCurrentLocation objectAtIndex:0],[getCurrentLocation objectAtIndex:1]];
	NSLog(@"FULL:%@",fullmessage);
	NSURL *url = [NSURL URLWithString:fullmessage];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
	[request setDelegate:self];
	[request startAsynchronous];
	[lo startAnimating];
	[ad setHidden:NO];
	[counting replaceObjectAtIndex:0 withObject:@"1"];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
    [((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:YES animated:YES];
	loManager=[[CLLocationManager alloc]init];
	loManager.delegate=self;
	loManager.distanceFilter=kCLDistanceFilterNone;
	loManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
	[loManager startUpdatingLocation];
	mapV.showsUserLocation=YES;
}
-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	/*[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).voNum setHidden:YES];
	[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).voNum setHidden:YES];*/
	[((totalNearby *)((TRONAppDelegate *)APPDELEGATE).totalNearbyWin).infoNeed removeAllObjects];
	[((totalNearby *)((TRONAppDelegate *)APPDELEGATE).totalNearbyWin).nearTotal reloadData];
	if ([[counting objectAtIndex:0]intValue]==0) {
		[mapV removeAnnotations:mapV.annotations];
		b=0;
		[mapButtonTag removeAllObjects];
		[mapDetail removeAllObjects];
		[mapDetail2 removeAllObjects];
		[testing removeAllObjects];
		[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:YES];
		//[getCurrentLocation replaceObjectAtIndex:0 withObject:@"3.0635"];
		//[getCurrentLocation replaceObjectAtIndex:1 withObject:@"101.6979"];
		if ([[getCurrentLocation objectAtIndex:0]isEqual:@"0"]) {
			NSLog(@"empty");
			[getCurrentLocation replaceObjectAtIndex:0 withObject:@"3.0635"];
			[getCurrentLocation replaceObjectAtIndex:1 withObject:@"101.6979"];
		}
		NSString *fullmessage=[NSString stringWithFormat:@"%@api/deal/featured/?loginKey=%@&apiKey=bdd2279f-ba2b-4c78-816b-1d438037461b&latlong=%@,%@&km=5",SERVER,[((loginMain *)((TRONAppDelegate *)APPDELEGATE).loginWin).userFinal objectAtIndex:0],[getCurrentLocation objectAtIndex:0],[getCurrentLocation objectAtIndex:1]];
		NSLog(@"FULL:%@",fullmessage);
		NSURL *url = [NSURL URLWithString:fullmessage];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"mode",nil]];
		[request setDelegate:self];
		[request startAsynchronous];
		[lo startAnimating];
		[ad setHidden:NO];
		[counting replaceObjectAtIndex:0 withObject:@"1"];
	}
	
}
- (void)viewDidLoad {
	allMapData = [[NSMutableArray alloc]init];
	mapDetail = [[NSMutableArray alloc]init];
	mapDetail2 = [[NSMutableArray alloc]init];
	sameCoor = [[NSMutableArray alloc]init];
	mapButtonTag = [[NSMutableArray alloc]init];
	[sameCoor addObject:@"0"];
	[sameCoor addObject:@"0"];
	[sameCoor addObject:@"-1"];
	[sameCoor addObject:@"-1"];
	storeCoor = [[NSMutableArray alloc]init];
	testing = [[NSMutableArray alloc]init];
	counting = [[NSMutableArray alloc]init];
	[counting addObject:@"0"];
	countFinalTotal = [[NSMutableArray alloc]init];
	count=0;
	countAgain=0;
	po=0;
	a=-1;
	b=0;
	countCoor=1;
	countTotal=0;
	getCurrentLocation = [[NSMutableArray alloc]init];
	[getCurrentLocation addObject:@"0"];
	[getCurrentLocation addObject:@"0"];
	weird = [[NSMutableArray alloc]init];
	[weird addObject:@"0"];
	counting2 = [[NSMutableArray alloc]init];
	[counting2 addObject:@"0"];
	[super viewDidLoad];
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
	NSLog(@"Scrolling");
	getLa = [NSString stringWithFormat:@"%f",mapV.centerCoordinate.latitude];
	getLo = [NSString stringWithFormat:@"%f",mapV.centerCoordinate.longitude];
	[getCurrentLocation replaceObjectAtIndex:0 withObject:getLa];
	[getCurrentLocation replaceObjectAtIndex:1 withObject:getLo];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
	@try {
		switch ([[[request userInfo] objectForKey:@"mode"] intValue]) {
			case 0:
			{
				NSString *mapDeal = [request responseString];
				SBJsonParser *parse = [[SBJsonParser alloc]init];
				dataMap = [parse objectWithString:mapDeal error:nil];
				NSString *error = [dataMap objectForKey:@"error_code"];
				if ([error intValue]==205 || [error intValue]==100) {
					UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"Please Login again!" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
					[alert show];
					[alert release];
					[((TRONAppDelegate *)APPDELEGATE).navBar setViewControllers:[NSArray arrayWithObject:((TRONAppDelegate *)APPDELEGATE).loginWin]];
					[((TRONAppDelegate *)APPDELEGATE).TABBAR setHidden:YES];
				}
				else {
					nearData = [dataMap objectForKey:@"nearby_deals"];
					[weird replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",[nearData count]]];
					for (int i=0; i<[nearData count]; i++) {
						nearList = [nearData objectAtIndex:i];
						NSLog(@"NEAR:%@",nearList);
						NSString *data = [nearList objectForKey:@"data_url"];
						NSString *latitu = [nearList objectForKey:@"google_lat"];
						NSString * longitu = [nearList objectForKey:@"google_long"];
						mapMechant2 = [nearList objectForKey:@"merchant"];
						NSString *name2 = [mapMechant2 objectForKey:@"name"];
						NSString *dealID2 = [nearList objectForKey:@"id"];
						NSString *logo = [nearList objectForKey:@"deal_image_thumbnail_url"];
						NSString *dealTitle2 = [nearList objectForKey:@"title"];
						NSString *place = [nearList objectForKey:@"place"];
						[mapDetail addObject:data];
						[mapDetail addObject:latitu];
						[mapDetail addObject:longitu];
						[mapDetail addObject:dealID2];
						[mapDetail addObject:name2];
						[mapDetail addObject:logo];
						[mapDetail addObject:dealTitle2];
						[mapDetail addObject:place];
						countAgain++;
					}
					count++;
				}
				break;
			}
		}
		NSLog(@"COUNT:%d",countAgain);
		NSLog(@"count FEACTURE:%d",[((featured *)((TRONAppDelegate *)APPDELEGATE).featureWin).dealInfo count]/7);
		if (countAgain==[[weird objectAtIndex:0]intValue]) {

			for (int i=0; i<[mapDetail count]/8; i++) {
				lat1 = [[mapDetail objectAtIndex:(i*8)+1]doubleValue];
				longt1 = [[mapDetail objectAtIndex:(i*8)+2]doubleValue];
				numTag = [[mapDetail objectAtIndex:(i*8)+1]doubleValue]*100000000;
				[mapButtonTag addObject:[NSString stringWithFormat:@"%d",numTag]];
                CLLocationCoordinate2D coordinate;
                coordinate.latitude = lat1;
                coordinate.longitude = longt1;
                MyPlacemark *mPlacemark = [[[MyPlacemark alloc] initWithCoordinate:coordinate] autorelease];
                NSString *tit = [NSString stringWithFormat:@"%@",[mapDetail objectAtIndex:(i*8)+4]];
				NSString *tit2 = [NSString stringWithFormat:@"%@",[mapDetail objectAtIndex:(i*8)+7]];
				NSString *sub = [NSString stringWithFormat:@"%@",[mapDetail objectAtIndex:(i*8)+6]];
                if ([tit2 isEqual:@""]) {
					[mPlacemark setTitle1:tit];
                    [mPlacemark setSubtitle1:sub];
				}
				else {
                    [mPlacemark setTitle1:tit2];
					[mPlacemark setSubtitle1:sub];
				}
                NSString *finally = [NSString stringWithFormat:@"%d",i];
				[testing addObject:sub];
				[testing addObject:[mapDetail objectAtIndex:(i*8)+5]];
				[testing addObject:[mapDetail objectAtIndex:(i*8)+3]];
				[testing addObject:tit];
				[testing addObject:finally];
                
                NSLog(@"hello2.2");
				[mapV addAnnotation:mPlacemark];
                NSLog(@"hello2.3");
			}
		}
		[lo stopAnimating];
		[ad setHidden:YES];
		[showRef setEnabled:YES];
	}
	@catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	}
	@finally {
		NSLog(@"Finally-NearBy");
	}
}
/*- (void)openCallout:(id<MKAnnotation>)annotation {
    [mapV selectAnnotation:annotation animated:YES];
}*/
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    if ([newLocation.timestamp timeIntervalSince1970] < [NSDate timeIntervalSinceReferenceDate] - 60)
        return;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 2000, 2000); 
    MKCoordinateRegion adjustedRegion = [mapV regionThatFits:viewRegion];
    [mapV setRegion:adjustedRegion animated:YES];
	getLa = [NSString stringWithFormat:@"%g",fabs(newLocation.coordinate.latitude)];
	getLo = [NSString stringWithFormat:@"%g",fabs(newLocation.coordinate.longitude)];
	[getCurrentLocation replaceObjectAtIndex:0 withObject:getLa];
	[getCurrentLocation replaceObjectAtIndex:1 withObject:getLo];
	//[getCurrentLocation replaceObjectAtIndex:0 withObject:@"3.0635"];
	//[getCurrentLocation replaceObjectAtIndex:1 withObject:@"101.6979"];

	NSLog(@"LATI :%@  LONT:%@",getLa,getLo);
     manager.delegate = nil;
    [manager stopUpdatingLocation];
    [manager autorelease];
    
    
    MKReverseGeocoder *geocoder = [[MKReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate];
    geocoder.delegate = self;
    [geocoder start];
}
#pragma mark -
#pragma mark Alert View Delegate Methods
#pragma mark -
#pragma mark Reverse Geocoder Delegate Methods
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
    
    geocoder.delegate = nil;
    [geocoder autorelease];
}

#pragma mark -
#pragma mark Map View Delegate Methods
- (MKAnnotationView *) mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>) annotation {
		NSString *placemarkIdentifier = @"Map Location Identifier";
        MKAnnotationView *annotationView = (MKAnnotationView *)[theMapView dequeueReusableAnnotationViewWithIdentifier:placemarkIdentifier];
        if (annotationView == nil)  {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:placemarkIdentifier];
		}
	if ([annotation isKindOfClass:[MKUserLocation class]])
		return nil;
			if (po==0) {
				//annotationView.animatesDrop = TRUE;
				addButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
				[addButton setTitle:[annotation subtitle] forState:UIControlStateNormal];
				NSLog(@"anno sub:%@",[annotation subtitle]);
				for (int i=0; i<[mapButtonTag count]; i++) {
					if ([[annotation subtitle]isEqual:[testing objectAtIndex:(i*5)]]) {
						[addButton setTag:[[mapButtonTag objectAtIndex:i]intValue]];
					}
				}
				b=b+1;
				[addButton addTarget:self action:@selector(displayExtraDetail:) forControlEvents:UIControlEventTouchUpInside];
				annotationView.rightCalloutAccessoryView=addButton;
				[annotationView setCanShowCallout:YES];
				[annotationView setSelected:YES animated:YES];
			NSLog(@"b:%d",b); 
			for (int i=0; i<[mapDetail count]/8; i++) {
				for (int j=0; j<[mapDetail count]/8; j++) {
					if ([addButton tag]==[[mapDetail objectAtIndex:(j*8)+1]doubleValue]*100000000) {
						countTotal++;
					}
				}
				if (countTotal>1) {
					annotationView.image = [UIImage imageNamed:@"tronblue.png"];
					annotationView.annotation=annotation;
					countTotal=0;
				}
				else {
					annotationView.image = [UIImage imageNamed:@"trongreen.png"];
					annotationView.annotation=annotation;
					countTotal=0;
				}
			}
			return annotationView;
			}
	NSLog(@"TRY");
}
-(void)displayExtraDetail:(UIButton *)sender
{
	[countFinalTotal removeAllObjects];
	countTotal=0;
	for (int i=0; i<[testing count]/5; i++) {
		if ([sender tag]==[[mapDetail objectAtIndex:(i*8)+1]doubleValue]*100000000) {
			countTotal++;
			NSString *wor = [NSString stringWithFormat:@"%d",i];
			[countFinalTotal addObject:wor];
			NSLog(@"TAG NAME:%@",[sender currentTitle]);
			NSLog(@"TAG NUM:%@",[testing objectAtIndex:(i*5)+1]);
			NSLog(@"TAG DEAL:%@",[testing objectAtIndex:(i*5)+2]);
		}
	}
	/*if (countTotal==1) {
		int row = [[countFinalTotal objectAtIndex:0]intValue];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:0 withObject:[testing objectAtIndex:(row*5)+1]];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:1 withObject:@"10"];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).row replaceObjectAtIndex:2 withObject:[testing objectAtIndex:(row*5)+2]];
		[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).dealWin animated:YES];
		[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).run startAnimating];
		[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).loaded setHidden:NO];
	}
	else {*/
		[((totalNearby *)((TRONAppDelegate *)APPDELEGATE).totalNearbyWin).counting replaceObjectAtIndex:0 withObject:@"0"];
		for (int i=0; i<countTotal; i++) {
			int row = [[countFinalTotal objectAtIndex:i]intValue];
			int row2 = [[testing objectAtIndex:(row*5)+4]intValue];
			[((totalNearby *)((TRONAppDelegate *)APPDELEGATE).totalNearbyWin).infoNeed addObject:[testing objectAtIndex:(row2*5)+2]];
			[((totalNearby *)((TRONAppDelegate *)APPDELEGATE).totalNearbyWin).infoNeed addObject:[mapDetail objectAtIndex:(row2*8)+6]];
			[((totalNearby *)((TRONAppDelegate *)APPDELEGATE).totalNearbyWin).infoNeed addObject:[mapDetail objectAtIndex:(row2*8)+4]];
			[((totalNearby *)((TRONAppDelegate *)APPDELEGATE).totalNearbyWin).infoNeed addObject:[mapDetail objectAtIndex:(row2*8)+5]];
		}
		[((TRONAppDelegate *)APPDELEGATE).navBar pushViewController:((TRONAppDelegate *)APPDELEGATE).totalNearbyWin animated:YES];
		[((TRONAppDelegate *)APPDELEGATE).navBar setNavigationBarHidden:NO animated:YES];
		[((totalNearby *)((TRONAppDelegate *)APPDELEGATE).totalNearbyWin).lo startAnimating];
		[((totalNearby *)((TRONAppDelegate *)APPDELEGATE).totalNearbyWin).ad setHidden:NO];
	//}

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
	[allMapData release];
	[mapDetail release];
	[mapDetail2 release];
	[sameCoor release];
	[mapButtonTag release];
	[storeCoor release];
	[testing release];
	[counting release];
	[countFinalTotal release];
	[getCurrentLocation release];
	[counting2 release];
	[mapV release];
    [super dealloc];
}


@end
