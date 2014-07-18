//
//  ShelterLocation.h
//  Shelter
//
//  Created by KArthik KAshyap on 7/17/14.
//  Copyright (c) 2014 SolsticExpressDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ShelterLocation : NSObject <MKAnnotation>
typedef enum {
    shelter=0,
    food,
    medicare

} ShelterCategory;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *beds;
@property (nonatomic, assign) ShelterCategory type;
- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;
@end
