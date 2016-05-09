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

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        // your code
    }
}


-(IBAction)captureSign:(id)sender {
    //display an alert to capture the person's name
    
    UIAlertController * alertView=   [UIAlertController
                                  alertControllerWithTitle:@"Saving signature with name"
                                  message:@"Please enter your name"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Name";

    }];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handel your yes please button action here
                                    UITextField *textField = alertView.textFields[0];
                                    userName = textField.text;
                                    
                                    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                                    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
                                    signedDate  = [dateFormatter stringFromDate:[NSDate date]];
                                    if(userName != nil && ![userName isEqualToString:@""] && signedDate != nil  && ![signedDate isEqualToString:@""])
                                    {
                                        [alertView dismissViewControllerAnimated:YES completion:nil];
                                        [self.signatureView captureSignature];
                                        [self startSampleProcess];
                                        [self.navigationController popToRootViewControllerAnimated:YES];
                                    }
                                   
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   //Handel no, thanks button
                                   [alertView dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [alertView addAction:yesButton];
    [alertView addAction:noButton];
    [self presentViewController:alertView animated:YES completion:nil];


}

- (UIImage *) imageWithView:(UIView *)view text:(NSString*)text
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // Setup the font specific variables
    NSDictionary *attributes = @{NSFontAttributeName           : [UIFont fontWithName:@"Helvetica" size:12],
                                 NSStrokeWidthAttributeName    : @(0),
                                 NSStrokeColorAttributeName    : [UIColor blackColor]};
    [text drawAtPoint:CGPointMake(view.frame.origin.x+10 , view.frame.size.height-25) withAttributes:attributes];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

-(void)startSampleProcess {
    UIImage *captureImage = [self.signatureView signatureImage];
    [self.delegate processCompleted:captureImage];
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
