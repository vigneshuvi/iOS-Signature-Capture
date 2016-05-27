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
                                        [self startSampleProcess:[NSString stringWithFormat:@"By: %@, %@",userName,signedDate]];
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

-(void)startSampleProcess:(NSString*)text {
    UIImage *captureImage = [self.signatureView signatureImage:CGPointMake(self.signatureView.frame.origin.x+10 , self.signatureView.frame.size.height-25) text:text];
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
