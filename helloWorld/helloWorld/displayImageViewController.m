//
//  displayImageViewController.m
//  helloWorld
//
//  Created by Mingzhe Xu on 6/8/15.
//  Copyright (c) 2015 Mingzhe Xu. All rights reserved.
//

#import "displayImageViewController.h"
#import "ViewController.h"

@interface displayImageViewController ()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation displayImageViewController

- (id) initWithImage: (UIImage *) image
{
    if(self = [super init]){
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 20, self.view.frame.size.height - 20)];
        self.image = image;
        self.imageView.image = self.image;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.image = self.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
