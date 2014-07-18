//
//  ShelterMapViewController.m
//  Shelter
//
//  Created by KArthik KAshyap on 7/17/14.
//  Copyright (c) 2014 SolsticExpressDay. All rights reserved.
//

#import "ShelterMapViewController.h"
#import "ShelterLocation.h"
#define METERS_PER_MILE 0.000621371

@interface ShelterMapViewController ()
@property (nonatomic, strong) NSMutableArray * shelterMaleLocations;
@property (nonatomic, strong) NSMutableArray * shelterFemaleLocations;
@property (nonatomic, strong) NSMutableArray * foodLocations;
@property (nonatomic, strong) NSMutableArray * educationLocations;
@property (nonatomic, strong) NSMutableArray * mediCareLocations;
@property (nonatomic, strong) NSMutableArray * donationLocations;
@property (nonatomic, strong) NSMutableArray * locationCollection;
@end

@implementation ShelterMapViewController
typedef enum {
    ShelterMale = 1,
    ShelterFemale,
    Food,
    Education,
    Medicare,
    Donation
    
} FilterType;

typedef enum {
    RemovePin = 0,
    AddPin = 1

} PinAction;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _shelterMapView.delegate = self;
    self.foodLocations = [[NSMutableArray alloc] init];
    self.shelterMaleLocations = [[NSMutableArray alloc] init];
    self.shelterFemaleLocations = [[NSMutableArray alloc] init];
    [self loadLocationFromSource:@"Food.plist" toCollection:self.shelterMaleLocations];
    [self loadLocationFromSource:@"property.plist" toCollection:self.shelterFemaleLocations];
    [self mapLocations];
    
}

-(void)mapLocations {
    
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(41.8858327415, -87.6413823149);
    MKCoordinateRegion region;
    region.center = loc;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    region.span=span;
    [self.shelterMapView setRegion:region animated:TRUE];
    [self addAnnotationOnMap:self.shelterMaleLocations];
     [self addAnnotationOnMap:self.shelterFemaleLocations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[ShelterLocation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_shelterMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            MKAnnotationView *pinAnnotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            pinAnnotationView.enabled = YES;
            pinAnnotationView.canShowCallout = YES;
            pinAnnotationView.image = [UIImage imageNamed:@"homePin.png"];
            return pinAnnotationView;
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    ShelterLocation *location = (ShelterLocation*)view.annotation;
    
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [location.mapItem openInMapsWithLaunchOptions:launchOptions];
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)annotationViews
{
    for (MKAnnotationView *annView in annotationViews)
    {
        CGRect endFrame = annView.frame;
        annView.frame = CGRectOffset(endFrame, 0, -500);
        [UIView animateWithDuration:0.5
                         animations:^{ annView.frame = endFrame; }];
    }
}



- (IBAction)filterButton:(id)sender {
    UIButton *button = (UIButton *)sender;

    if(button.tag %100 != 0) {
        [button setImage:[UIImage imageNamed:@"uncheckbox.png"] forState:UIControlStateNormal];
        [self updateMapWithFilter:button.tag andAction:RemovePin];
        button.tag = button.tag *100;
    } else {
        [button setImage:[UIImage imageNamed:@"checked3.png"] forState:UIControlStateNormal];
        button.tag = (int)button.tag/100;
        [self updateMapWithFilter:button.tag andAction:AddPin];
    }
}


- (void)updateMapWithFilter:(FilterType)filterIndex andAction:(PinAction)action {
    switch (filterIndex) {
        case ShelterMale:
            action ? [self addAnnotationOnMap:self.shelterMaleLocations] :
            [self removeAnnotationOnMAp:self.shelterMaleLocations];
            break;
            
        case ShelterFemale:
            action ? [self addAnnotationOnMap:self.shelterFemaleLocations] :
            [self removeAnnotationOnMAp:self.shelterFemaleLocations];
            break;
            
        case Food:
            action ? [self addAnnotationOnMap:self.foodLocations] :
            [self removeAnnotationOnMAp:self.foodLocations];
            break;
            
        case Education:
            action ? [self addAnnotationOnMap:self.educationLocations] :
            [self removeAnnotationOnMAp:self.educationLocations];
            break;
            
        case Medicare:
            action ? [self addAnnotationOnMap:self.mediCareLocations] :
            [self removeAnnotationOnMAp:self.mediCareLocations];
            break;
            
        case Donation:
            action ? [self addAnnotationOnMap:self.donationLocations] :
            [self removeAnnotationOnMAp:self.donationLocations];
            break;
            
        default:
            break;
    }
}

- (void)addAnnotationOnMap:(NSArray *)locations {
    [self.shelterMapView addAnnotations:locations];
    [self.shelterMapView reloadInputViews];
}

- (void)removeAnnotationOnMAp:(NSArray *)locaitons {
    [self.shelterMapView removeAnnotations:locaitons];
    [self.shelterMapView reloadInputViews];
}
- (void)loadLocationFromSource:(NSString *)source toCollection:(NSMutableArray *)collection{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:source];
    NSDictionary *plistData = [NSArray arrayWithContentsOfFile:finalPath];
    NSLog(@"food :%@",plistData);
    for (NSObject * data in plistData) {
        CLLocationCoordinate2D  loc = CLLocationCoordinate2DMake([[data valueForKeyPath:@"Latitude"] doubleValue], [[data valueForKeyPath:@"Longitude"] doubleValue]);
        ShelterLocation * location = [[ShelterLocation alloc] initWithName:[data valueForKeyPath:@"Shelter Name"] address:[data valueForKeyPath:@"Street"] coordinate:loc];
        location.phone = [data valueForKeyPath:@"Phone"];
        location.beds = [data valueForKeyPath:@"beds"];
        [collection addObject:location];
    }
}

@end
