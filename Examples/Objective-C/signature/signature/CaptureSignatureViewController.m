//
//  CaptureSignatureViewController.m
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

#import "CaptureSignatureViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface CaptureSignatureViewController ()

@end

@implementation CaptureSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)captureSign:(id)sender {
    [self startSampleProcess];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

-(void)startSampleProcess {
    [self.delegate processCompleted:[self imageWithView:self.signatureView]];
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
