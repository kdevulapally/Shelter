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
    [self mapLocations];
}

-(void)mapLocations {
    
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(41.8858327415, -87.6413823149);
    
    ShelterLocation *annotation = [[ShelterLocation alloc] initWithName:@"TEST" address:@"111 N Canal" coordinate:loc];
    [self.shelterMapView addAnnotation:annotation];
    
    MKCoordinateRegion region;
    region.center = loc;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    region.span=span;
    [self.shelterMapView setRegion:region animated:TRUE];
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
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_shelterMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"general_pin.png "];//here we use a nice image instead of the default pins
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
- (IBAction)filterButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    if(button.tag %100 != 0) {
        [button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        [self updateMapWithFilter:button.tag/100 andAction:AddPin];
        button.tag = button.tag *100;
    } else {
        [button setImage:[UIImage imageNamed:@"uncheckbox.png"] forState:UIControlStateNormal];
        button.tag = (int)button.tag/100;
        [self updateMapWithFilter:button.tag andAction:RemovePin];
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
    for (ShelterLocation * shelter in locations) {
        [self.shelterMapView addAnnotation:shelter];
    }
}

- (void)removeAnnotationOnMAp:(NSArray *)locaitons {
    for (ShelterLocation * shelter in locaitons) {
        [self.shelterMapView removeAnnotation:shelter];
    }
}

@end
