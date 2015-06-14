//
//  ViewController.m
//  helloWorld
//
//  Created by Mingzhe Xu on 6/7/15.
//  Copyright (c) 2015 Mingzhe Xu. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "displayImageViewController.h"

@interface ViewController()

@property (weak, nonatomic) IBOutlet UIButton *displayImage;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) CLLocationDirection currentHeading;
@property (nonatomic) CLLocationManager *locManager;

@end

@implementation ViewController {
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    geocoder = [[CLGeocoder alloc] init];
    self.capturedImages = [[NSMutableArray alloc] init];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // If there is not a camera on this device, so don't show the camera button.
    }
}
- (IBAction)showImage:(id)sender {
    
    UIViewController *myController = [[displayImageViewController alloc] initWithImage:self.image];
    [self.navigationController pushViewController:myController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMessage
{
    UIAlertView *helloWorldAlert = [[UIAlertView alloc]
                                    initWithTitle:@"My First App" message:@"Hello, World!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display the Hello World Message
    [helloWorldAlert show];
}

// ===================== camera starts =====================

- (IBAction)startCamera:(id)sender {
    
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
    
    // =========== location included =========================
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 500; // meters
    
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
    
    // Start heading updates.
//    if ([CLLocationManager headingAvailable]) {
//        locationManager.headingFilter = 5;
//        [locationManager startUpdatingHeading];
//    }
    
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// For responding to the user choosing this photo
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum (image, nil, nil , nil);
    [self.capturedImages addObject:image];
    
    [self finishAndUpdate];
}


- (IBAction)showImagePickerForPhotoPicker:(id)sender
{
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}


- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if (self.imageView.isAnimating)
    {
        [self.imageView stopAnimating];
    }
    
    if (self.capturedImages.count > 0)
    {
        [self.capturedImages removeAllObjects];
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        /*
         The user wants to use the camera interface. Set up our custom overlay view for the camera.
         */
        // imagePickerController.showsCameraControls = NO;
        
        /*
         Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
         */
        [[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
        self.overlayView.frame = imagePickerController.cameraOverlayView.frame;
        imagePickerController.cameraOverlayView = self.overlayView;
        self.overlayView = nil;
    }
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}


#pragma mark - Toolbar actions

- (IBAction)done:(id)sender
{
    [self finishAndUpdate];
}

- (void)finishAndUpdate
{
    self.image = [self.capturedImages objectAtIndex:0];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    displayImageViewController *myController = [[displayImageViewController alloc] initWithImage: self.image];
    
    [self.navigationController pushViewController:myController animated:YES];
    
}

// ===================== get Location =====================
// get the location by clicking the get location button
- (IBAction)getCurrentLocation:(id)sender{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 500; // meters
    
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
        
    }
    [locationManager startUpdatingLocation];
    
    // Start heading updates.
    if ([CLLocationManager headingAvailable]) {
        locationManager.headingFilter = 5;
        [locationManager startUpdatingHeading];
    }

    
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to get your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    
    NSLog(@"successful - latitude %.2f, longitude %.2f\n",
          location.coordinate.latitude,
          location.coordinate.longitude);
    
    self.latitudeLabel.text = [NSString stringWithFormat:@"%.2f",location.coordinate.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%.2f",location.coordinate.longitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         // NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
         if (error == nil && [placemarks count] > 0) {
             placemark = [placemarks lastObject];
             self.addressLabel.text = [NSString stringWithFormat:@"%@ \n %@ %@ \n %@ %@ \n %@ %@", placemark.name, placemark.thoroughfare, placemark.subThoroughfare, placemark.locality, placemark.administrativeArea, placemark.postalCode, placemark.country];
         } else {
             NSLog(@"%@", error.debugDescription);
         }
     }];
    
}

// ===================== HEADING ==========================


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    
    self.currentHeading = theHeading;
    
    if((360 - 45/2 < self.currentHeading && self.currentHeading < 360) || (0 < self.currentHeading && self.currentHeading < 45/2))
    {
        self.dirLabel.text = @"N";
    }else{
        self.dirLabel.text = [NSString stringWithFormat:@"%.2f" , self.currentHeading];
    }
}

@end
