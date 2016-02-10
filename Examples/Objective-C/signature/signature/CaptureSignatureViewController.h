//
//  CaptureSignatureViewController.h
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UviSignatureView.h"

// Protocol definition starts here
@protocol CaptureSignatureViewDelegate <NSObject>
@required
- (void)processCompleted:(UIImage*)signImage;
@end


@interface CaptureSignatureViewController : UIViewController {
    // Delegate to respond back
    id <CaptureSignatureViewDelegate> _delegate;
}

@property (nonatomic,strong) id delegate;
-(void)startSampleProcess; // Instance method

@property (strong, nonatomic) IBOutlet UviSignatureView *signatureView;
- (IBAction)captureSign:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *captureButton;

@end
