//
//  ViewController.m
//  MapMyPoints
//
//  Created by El Mehdi LAIDOUNI on 2016-01-07.
//  Copyright © 2016 El Mehdi LAIDOUNI. All rights reserved.
//
#import "MapKit/MapKit.h"
#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKPointAnnotation *cuswgAnnotaion;
@property (strong, nonatomic) MKPointAnnotation *ubcAnnotaion;
@property (strong, nonatomic) MKPointAnnotation *uoftAnnotaion;
@property (strong, nonatomic) MKPointAnnotation *currentAnnotation;
@property (weak, nonatomic) IBOutlet UISwitch *switchField;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL mapIsMoving;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.mapIsMoving = NO;
    [self addAnnotaions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)luciTapped:(id)sender {
    [self centerMap:self.cuswgAnnotaion];
}
- (IBAction)wiclTapped:(id)sender {
    [self centerMap:self.ubcAnnotaion];
}
- (IBAction)gradientTapped:(id)sender {
    [self centerMap:self.uoftAnnotaion];
}
- (IBAction)switchChanged:(id)sender {
    if(self.switchField.isOn) {
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
    }
    else {
        self.mapView.showsUserLocation = NO;
        [self.locationManager stopUpdatingLocation];
        
    }
    
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.currentAnnotation.coordinate = locations.lastObject.coordinate;
    
    if (self.mapIsMoving == NO) {
        [self centerMap:self.currentAnnotation];
    }

    
}
- (void) centerMap: (MKPointAnnotation *) centerPoint {
    [self.mapView setCenterCoordinate:centerPoint.coordinate animated:YES];
}
- (void) addAnnotaions {
    self.cuswgAnnotaion = [[MKPointAnnotation alloc] init];
    self.cuswgAnnotaion.coordinate = CLLocationCoordinate2DMake(30.4043407440186,-9.59889030456543);
    self.cuswgAnnotaion.title = @"Chemin Des Dunes, Agadir, Maroc";
    
    self.ubcAnnotaion = [[MKPointAnnotation alloc] init];
    self.ubcAnnotaion.coordinate = CLLocationCoordinate2DMake(46.4386787414551,6.90611982345581);
    self.ubcAnnotaion.title = @"100 Grand Rue, Montreux, Switzerland";
    
    self.uoftAnnotaion = [[MKPointAnnotation alloc] init];
    self.uoftAnnotaion.coordinate = CLLocationCoordinate2DMake(25.817699432373,-80.1231384277344);
    self.uoftAnnotaion.title = @"4441 Collins Avenue, Miami Beach, Florida, USA";
    
    self.currentAnnotation = [[MKPointAnnotation alloc] init];
    self.currentAnnotation.coordinate = CLLocationCoordinate2DMake(0, 0);
    self.currentAnnotation.title = @"My Location";
    
    [self.mapView addAnnotations:@[self.cuswgAnnotaion, self.ubcAnnotaion, self.uoftAnnotaion]];
    
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
        self.mapIsMoving = NO;
}

@end
