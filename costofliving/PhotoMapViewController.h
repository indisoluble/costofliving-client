//
//  PhotoMapViewController.h
//  costofliving
//
//  Created by Enrique de la Torre on 01/04/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface PhotoMapViewController : UIViewController {
    MKMapView *_mapView;
    
    NSArray *_products;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (nonatomic, retain) NSArray *products;

@end
