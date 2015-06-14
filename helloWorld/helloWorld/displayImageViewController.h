//
//  displayImageViewController.h
//  helloWorld
//
//  Created by Mingzhe Xu on 6/8/15.
//  Copyright (c) 2015 Mingzhe Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface displayImageViewController : UIViewController

- (id) initWithImage: (UIImage *) image;

@property UIImageView *showImage;

@property UIBarButtonItem *modify;

@end
