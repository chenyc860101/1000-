    //
//  showMap.m
//  TRON
//
//  Created by Wu Ming on 5/23/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "showMap.h"
#import "MyPlacemark.h"

@implementation showMap
@synthesize mapRes,selec;

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
	[super viewDidAppear:YES];
	[mapRes removeAnnotations:mapRes.annotations];
	NSInteger value = [[selec objectAtIndex:0]intValue];
	self.mapRes.delegate=self;
	[mapRes setMapType:MKMapTypeStandard];
	CLLocationManager *locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate=self;
	locationManager.desiredAccuracy=kCLLocationAccuracyBest;
	locationManager.distanceFilter=1000.0f;
	[locationManager startUpdatingLocation];
	
	MKCoordinateRegion theRegion = { {0.0, 0.0 }, { 0.0, 0.0 } };
	theRegion.center=[[locationManager location] coordinate];
	[locationManager release];
	[mapRes setZoomEnabled:YES];
	[mapRes setScrollEnabled:YES];
	NSString *checkingLatitude = [NSString stringWithFormat:@"%@",[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).outletDetail objectAtIndex:(value*5)+2]];
	if ([checkingLatitude isEqual:@"<null>"]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tron Notification" message:@"Not Coordinate Found" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
		[alert release];
		latitude = -1;
		longtitude = -1;
	}
	else {
		latitude = [[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).outletDetail objectAtIndex:(value*5)+2]doubleValue];
		longtitude = [[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).outletDetail objectAtIndex:(value*5)+3]doubleValue];
	}
	theRegion.center.latitude = latitude;
	theRegion.center.longitude = longtitude;
	theRegion.span.longitudeDelta = 0.003f;
	theRegion.span.latitudeDelta = 0.003f;
	[mapRes setRegion:theRegion animated:YES];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longtitude;
    MyPlacemark *mPlacemark = [[[MyPlacemark alloc] initWithCoordinate:coordinate] autorelease];
    [mPlacemark setTitle1:[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).outletDetail objectAtIndex:(value*5)+4]];
	[mapRes addAnnotation:mPlacemark];

}
- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *AnnotationViewID = @"annotationViewID";
	
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapRes dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
	
    if (annotationView == nil)
    {
        annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
    }
    addButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [addButton addTarget:self action:@selector(display) forControlEvents:UIControlEventTouchUpInside];
    annotationView.rightCalloutAccessoryView=addButton;

	annotationView.canShowCallout=YES;
    annotationView.image = [UIImage imageNamed:@"trongreen.png"];
    annotationView.annotation = annotation;
	
    return annotationView;
}
-(void)display

{
    
    NSInteger value = [[selec objectAtIndex:0]intValue];
    NSLog(@"lala:%@", [((nearBy *)((TRONAppDelegate *)APPDELEGATE).nearWin).getCurrentLocation objectAtIndex:0]);
    if ([[((nearBy *)((TRONAppDelegate *)APPDELEGATE).nearWin).getCurrentLocation objectAtIndex:0]isEqual:@"0"]) {
        NSLog(@"empty");
        [((nearBy *)((TRONAppDelegate *)APPDELEGATE).nearWin).getCurrentLocation replaceObjectAtIndex:0 withObject:@"3.0635"];
        [((nearBy *)((TRONAppDelegate *)APPDELEGATE).nearWin).getCurrentLocation replaceObjectAtIndex:1 withObject:@"101.6979"];
    }
    double lalstart = [[((nearBy *)((TRONAppDelegate *)APPDELEGATE).nearWin).getCurrentLocation objectAtIndex:0]doubleValue];
    
    double lolstart = [[((nearBy *)((TRONAppDelegate *)APPDELEGATE).nearWin).getCurrentLocation objectAtIndex:1]doubleValue];
    CLLocationCoordinate2D start = { lalstart, lolstart };
    
    double lal = [[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).outletDetail objectAtIndex:(value*5)+2]doubleValue];
    
    double lol = [[((deals *)((TRONAppDelegate *)APPDELEGATE).dealWin).outletDetail objectAtIndex:(value*5)+3]doubleValue];
    
    CLLocationCoordinate2D destination = { lal, lol };      
    
    
    NSString *googleMapsURLString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=My+Location&daddr=%1.6f,%1.6f",
                                     
                                     destination.latitude, destination.longitude];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapsURLString]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	selec = [[NSMutableArray alloc]init];
	[selec addObject:@"0"];
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


- (void)dealloc {
	[selec release];
	[mapRes release];
    [super dealloc];
}


@end
