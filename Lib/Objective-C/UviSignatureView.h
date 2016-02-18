//
//  CustomSignatureView.h
//  UviGLSignature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UviSignatureView : UIView {
    UIBezierPath *signPath;
    CGPoint previousPoint;
}

@end
