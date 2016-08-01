//
//  ViewController.h
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CaptureSignatureViewController.h"


@interface ViewController : UIViewController<CaptureSignatureViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *signatureImageView;


@end

