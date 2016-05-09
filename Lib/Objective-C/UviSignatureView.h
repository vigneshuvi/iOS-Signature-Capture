//
//  CustomSignatureView.h
//  UviGLSignature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

#import <UIKit/UIKit.h>

// Protocol definition starts here
@protocol UviSignatureViewDelegate <NSObject>
@required
- (void)shakeCompleted;
@end

@interface UviSignatureView : UIView {
    CGPoint previousPoint;
    UIBezierPath *signPath;
    NSMutableArray *pathArray;
    NSArray *backgroundLines;
}

@property (nonatomic, strong, nullable) UIColor *lineColor;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, readonly) BOOL signatureExists;
- (void)captureSignature;
- (UIImage *)signatureImage;

@end
