//
//  ShelterMapViewController.h
//  Shelter
//
//  Created by KArthik KAshyap on 7/17/14.
//  Copyright (c) 2014 SolsticExpressDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ShelterMapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *shelterMapView;

@property (weak, nonatomic) IBOutlet UIButton *filterButton;
- (IBAction)refresh:(id)sender;

@end
