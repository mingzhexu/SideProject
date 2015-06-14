//
//  GraphicViewController.m
//  helloWorld
//
//  Created by Mingzhe Xu on 6/12/15.
//  Copyright (c) 2015 Mingzhe Xu. All rights reserved.
//

#import "GraphicViewController.h"

#define TOOLBAR_HEIGHT 50

@interface GraphicViewController ()

@end

@implementation GraphicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 10, self.view.frame.size.height - 60)];
    backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    backgroundView.backgroundColor = [UIColor redColor];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor = [UIColor blackColor];

    [self.view addSubview:backgroundView];
    
    CGRect toolbarFrame = self.view.frame;
    toolbarFrame.origin.x = 0;
    toolbarFrame.origin.y = toolbarFrame.size.height - TOOLBAR_HEIGHT;
    toolbarFrame.size.height = TOOLBAR_HEIGHT;

    toolbar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    toolbar.barStyle = UIBarStyleDefault;
    
//    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTapped)];
//    UIBarButtonItem *finishButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterTapped)];
    
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
