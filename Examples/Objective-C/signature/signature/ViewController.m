//
//  ViewController.m
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat borderWidth = 2.0f;
    
    self.signatureImageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.signatureImageView.layer.borderWidth = borderWidth;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//implementation of delegate method
- (void)processCompleted:(UIImage*)signImage
{
    _signatureImageView.image = signImage;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier hasPrefix:@"view_to_capture"]) {
        CaptureSignatureViewController *destination = segue.destinationViewController;
        destination.delegate = self;
    }
}

#pragma mark - Sample protocol delegate


@end
