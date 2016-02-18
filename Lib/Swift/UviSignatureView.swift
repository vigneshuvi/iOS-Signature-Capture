        //
//  UviSignatureView.swift
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

import UIKit
import QuartzCore

class UviSignatureView: UIView {
    var signPath: UIBezierPath = UIBezierPath()
    var previousPoint: CGPoint  = CGPoint.init(x: 0, y: 0)
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
        self.initialize()
    }
    
    init(_ coder: NSCoder? = nil) {
        if let coder = coder {
            super.init(coder: coder)!
        }
        else {
            super.init(frame: CGRectZero)
        }
        self.initialize()
    }
    
    // Initial the Siganture view based on the frame.
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.initialize()
    }
    
    func midpoint(p0: CGPoint, p1: CGPoint) -> CGPoint {
        let mid :CGPoint = CGPoint.init(x: ((p0.x + p1.x) / 2.0), y: ((p0.y + p1.y) / 2.0))
        return mid;
    }

   // Configurate the line Width
   func initialize() {
        signPath = UIBezierPath();
        signPath.lineWidth = 2.0            // Configurate the line Width
        self.userInteractionEnabled = true
        previousPoint = CGPoint.init(x: 0, y: 0)
        
        // Added the Pan Reconginzer for capture the touches
        let panRecognizer = UIPanGestureRecognizer(target:self, action:"panRecognizer:")
        panRecognizer.minimumNumberOfTouches = 1
        self.addGestureRecognizer(panRecognizer);
        

        
        // Erase when long press the view.
        let eraseRecognizer = UILongPressGestureRecognizer(target:self, action:"eraseRecognizer:")
         self.addGestureRecognizer(eraseRecognizer);
        
        
        // Erase the view when recieving a notification named "shake" from the NSNotificationCenter object
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "erase",
            name: "shake",
            object: nil);
    }

    // panReconizer method triggers while touch the view.
    func panRecognizer(recognizer:UIPanGestureRecognizer) {
        let currentPoint = recognizer.locationInView(self);
        let midPoint:CGPoint = midpoint(previousPoint, p1: currentPoint)
        
        switch(recognizer.state) {
            case UIGestureRecognizerState.Began:
                signPath.moveToPoint(currentPoint)
                break;
            
            case UIGestureRecognizerState.Changed:
                 signPath.addQuadCurveToPoint(midPoint, controlPoint: previousPoint);
                break;
            
            case UIGestureRecognizerState.Recognized:
                 signPath.addQuadCurveToPoint(midPoint, controlPoint: previousPoint);
                break;
            
            case UIGestureRecognizerState.Possible:
                signPath.addQuadCurveToPoint(midPoint, controlPoint: previousPoint);
                break;
            
            default:
                break;
        }
        
        previousPoint = currentPoint;
        
        self.setNeedsDisplay(); // Update the view.
    }
    
    // eraseRecognizer method triggers while long press the view.
    func eraseRecognizer(recognizer:UILongPressGestureRecognizer) {
        self.erase()
    }
    
    // Erase the Siganture view by initial the new path.
    func erase() {
        signPath.closePath()
        signPath = UIBezierPath();
         previousPoint = CGPoint.init(x: 0, y: 0)
        self.setNeedsDisplay(); // Update the view.
    }


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        UIColor.blackColor().setStroke()
        signPath.stroke()
       
    }


}
