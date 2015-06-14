//
//  ViewController.h
//  helloWorld
//
//  Created by Mingzhe Xu on 6/7/15.
//  Copyright (c) 2015 Mingzhe Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <UIPopoverControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic) IBOutlet UIView *overlayView;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic) UIImagePickerController *imagePickerController;

@property (nonatomic) NSMutableArray *capturedImages;

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@property (nonatomic) BOOL usingPopover;

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;

@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

- (IBAction)getCurrentLocation:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *dirLabel;

@end

