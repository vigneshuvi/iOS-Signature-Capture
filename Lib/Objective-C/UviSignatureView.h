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
    NSArray *backgroundLines;
}

@property (nonatomic, strong, nonnull) NSMutableArray *pathArray;
@property (nonatomic, strong, nullable) UIColor *lineColor;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, readonly) BOOL signatureExists;
- (void)captureSignature;
- (UIImage*_Nullable)signatureImage:(CGPoint)position text:(NSString*_Nullable)text;

@end
