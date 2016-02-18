//
//  CustomSignatureView.m
//  UviGLSignature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

#import "UviSignatureView.h"
#import <QuartzCore/QuartzCore.h>



static CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}

@implementation UviSignatureView

// Initial the Siganture view based on the aDecoder.
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) [self initialize];
    return self;
}

// Initial the Siganture view based on the frame.
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) [self initialize];
    return self;
}

- (void)initialize {
    
    signPath = [UIBezierPath bezierPath];
    [signPath setLineWidth:2.0];            // Configurate the line Width
    [signPath setLineCapStyle:kCGLineCapRound];
    [signPath setLineJoinStyle:kCGLineJoinRound];
    
    // Added the Pan Reconginzer for capture the touches
    UIPanGestureRecognizer *panReconizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panReconizer:)];
    panReconizer.maximumNumberOfTouches = panReconizer.minimumNumberOfTouches = 1;
    [self addGestureRecognizer:panReconizer];
    
    // Erase when long press the view.
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(erase)]];
    
    // Erase when double tap the view.
    UITapGestureRecognizer *tapReconizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(erase)];
    [tapReconizer setNumberOfTouchesRequired : 2];
    [self addGestureRecognizer:tapReconizer];
    
    // Erase the view when recieving a notification named "shake" from the NSNotificationCenter object
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(erase) name:@"shake" object:nil];
    
}


// Erase the Siganture view by initial the new path.
- (void)erase {
   signPath = [UIBezierPath bezierPath];
   [signPath setLineWidth:2.0];
    [signPath setLineCapStyle:kCGLineCapRound];
    [signPath setLineJoinStyle:kCGLineJoinRound];
   [self setNeedsDisplay];             // Update the view.
}

// panReconizer method triggers while touch the view.
- (void)panReconizer:(UIPanGestureRecognizer *)pan {
    
    CGPoint currentPoint = [pan locationInView:self];
    CGPoint midPoint = midpoint(previousPoint, currentPoint);
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [signPath moveToPoint:currentPoint];
            break;
            
        case UIGestureRecognizerStateChanged:
            [signPath addQuadCurveToPoint:midPoint controlPoint:previousPoint];
            break;
            
        case UIGestureRecognizerStateRecognized:
            [signPath addQuadCurveToPoint:midPoint controlPoint:previousPoint];
            break;
            
        case UIGestureRecognizerStatePossible:
            [signPath addQuadCurveToPoint:midPoint controlPoint:previousPoint];
            break;
            
        default:
            break;
    }
    
    previousPoint = currentPoint;
    
    [self setNeedsDisplay]; // Update the view.
}

// Setup the stroke color.
- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] setStroke];
    [signPath stroke];
}


@end
