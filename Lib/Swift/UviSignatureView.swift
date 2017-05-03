//
//  UviSignatureView.swift
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

import UIKit
import QuartzCore


public let USER_SIGNATURE_PATH = "user_signature_path"

@IBDesignable
public class UviSignatureView: UIView {
    var signPath: UIBezierPath = UIBezierPath()
    var previousPoint: CGPoint  = CGPoint.init(x: 0, y: 0)
    var pathArray: NSMutableArray!
    var lineColor: UIColor = UIColor.black;
    var lineWidth : CGFloat = 0.0;
    let placeHolderString: NSString = "Sign here";
    
    public required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
        self.initialize()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    public init(_ coder: NSCoder? = nil) {
        if let coder = coder {
            super.init(coder: coder)!
        }
        else {
            super.init(frame: CGRect.zero)
        }
        self.initialize()
    }
    
    // Initial the Siganture view based on the frame.
    public override init(frame:CGRect) {
        super.init(frame:frame)
        self.initialize()
    }
    
    func midpoint(_ p0: CGPoint, p1: CGPoint) -> CGPoint {
        let mid :CGPoint = CGPoint.init(x: ((p0.x + p1.x) / 2.0), y: ((p0.y + p1.y) / 2.0))
        return mid;
    }
    
    // Configurate the line Width
    internal func initialize() {
        signPath = UIBezierPath();
        signPath.lineWidth = 2.0;            // Configurate the line Width
        self.isUserInteractionEnabled = true;
        previousPoint = CGPoint.init(x: 0, y: 0);
        pathArray = NSMutableArray();
        
        // Added the Pan Reconginzer for capture the touches
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(UviSignatureView.panRecognizer(_:)))
        panRecognizer.minimumNumberOfTouches = 1
        self.addGestureRecognizer(panRecognizer);
        
        let tabRecognizer = UITapGestureRecognizer(target:self, action:#selector(UviSignatureView.handleTap(_:)))
         tabRecognizer.numberOfTapsRequired = 1;
        tabRecognizer.numberOfTouchesRequired = 1;
        self.addGestureRecognizer(tabRecognizer);
        
        
        // Erase when long press the view.
        let eraseRecognizer = UILongPressGestureRecognizer(target:self, action:#selector(UviSignatureView.eraseRecognizer(_:)))
        
        self.addGestureRecognizer(eraseRecognizer);
        
        
        // Erase the view when recieving a notification named "shake" from the NSNotificationCenter object
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UviSignatureView.erase),
            name: NSNotification.Name(rawValue: "shake"),
            object: nil);
    }
    
    internal func placeholderPoint() -> CGPoint {
        let height:CGFloat = self.bounds.size.height;
        
        let bottom:CGFloat = 0.90;
        
        let x1: CGFloat = 0;
        
        let y1:CGFloat = height*bottom;
        let font:UIFont = UIFont(name: "Helvetica", size: 12)!;
        return CGPoint(x: x1, y: y1 - 5 - font.pointSize + font.descender);
    }
    
    // Set background Lines
    internal func backgroundLines()-> NSArray {
        var bgLinges = NSArray();
        let width:CGFloat = self.bounds.size.width;
        let height:CGFloat = self.bounds.size.height;
        
        let path:UIBezierPath = UIBezierPath();
        
        let bottom:CGFloat = 0.90;
        
        let x1:CGFloat = 0;
        let x2:CGFloat = width;
        
        let y1:CGFloat = height*bottom;
        let y2:CGFloat = height*bottom;
        
        path.move(to: CGPoint(x: x1, y: y1));
        path.addLine(to: CGPoint(x: x2, y: y2));
        
        bgLinges = [path];
        return bgLinges;
    }
    
    // Set background Lines
    public func pathArray(_ array:NSMutableArray)-> NSMutableArray {
        if self.pathArray == nil {
            pathArray = NSMutableArray();
        }
        
        if array.count > 0 {
            pathArray = array;
        }
        
        return pathArray;
    }
    
    func handleTap(_ recognizer: UITapGestureRecognizer) {
        // handling code
        let currentPoint = recognizer.location(in: self);
        let previousPoint:CGPoint  = CGPoint(x: currentPoint.x, y: currentPoint.y-3);
        let midPoint:CGPoint = midpoint(previousPoint, p1: currentPoint)
        signPath.move(to: currentPoint)
        signPath.addLine(to: midPoint);
        
        self.setNeedsDisplay(); // Update the view.
    }
    
    // panReconizer method triggers while touch the view.
    func panRecognizer(_ recognizer:UIPanGestureRecognizer) {
        let currentPoint = recognizer.location(in: self);
        let midPoint:CGPoint = midpoint(previousPoint, p1: currentPoint)
        
        switch(recognizer.state) {
        case UIGestureRecognizerState.began:
            signPath.move(to: currentPoint)
            break;
            
        case UIGestureRecognizerState.changed:
            signPath.addQuadCurve(to: midPoint, controlPoint: previousPoint);
            break;
            
        case UIGestureRecognizerState.ended:
            signPath.addQuadCurve(to: midPoint, controlPoint: previousPoint);
            break;
            
        case UIGestureRecognizerState.possible:
            signPath.addQuadCurve(to: midPoint, controlPoint: previousPoint);
            break;
            
        default:
            break;
        }
        
        previousPoint = currentPoint;
        
        self.setNeedsDisplay(); // Update the view.
    }
    
    // eraseRecognizer method triggers while long press the view.
    public func eraseRecognizer(_ recognizer:UILongPressGestureRecognizer) {
        self.erase()
    }
    
    // Erase the Siganture view by initial the new path.
    internal func erase() {
        //signPath.closePath()
        UserDefaults.standard.removeObject(forKey: USER_SIGNATURE_PATH);
        UserDefaults.standard.synchronize();
        pathArray.removeAllObjects();
        signPath = UIBezierPath();
        previousPoint = CGPoint.init(x: 0, y: 0)
        self.setNeedsDisplay(); // Update the view.
    }
    
    public func signatureExists()->Bool {
        return self.pathArray.count > 0;
    }
    
    public func captureSignature() {
        pathArray.add(signPath);
        let saveData:Data = NSKeyedArchiver.archivedData(withRootObject: pathArray);
        UserDefaults.standard.set(saveData, forKey: USER_SIGNATURE_PATH)
        UserDefaults.standard.synchronize();
    }
    
    public func signatureImage(_ text : NSString, position : CGPoint)-> UIImage {
        UIGraphicsBeginImageContext(self.bounds.size);
        
        if(!text.isEqual(to: "")) {
            // Setup the font specific variables
            let attributes :[String:AnyObject] = [
                NSFontAttributeName : UIFont(name: "Helvetica", size: 12)!,
                NSStrokeWidthAttributeName : 0 as AnyObject,
                NSForegroundColorAttributeName : UIColor.black
            ]
            text.draw(at: position, withAttributes: attributes);
        }
        
        
        for path in (self.pathArray) {
            self.lineColor.setStroke();
            (path as AnyObject).stroke();
        }
        
        
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return image;
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.black.setStroke()
        signPath.stroke()
        
        UIColor.white.setFill();
        UIGraphicsGetCurrentContext()?.fill(rect);
        
        for path in self.backgroundLines() {
            UIColor.black.withAlphaComponent(0.2).setStroke();
            (path as AnyObject).stroke();
        }
        
        if (!self.signatureExists() && self.signPath.isEmpty) {
            
            // Setup the font specific variables
            let attributes :[String:AnyObject] = [
                NSFontAttributeName : UIFont(name: "Helvetica", size: 12)!,
                NSStrokeWidthAttributeName : 0 as AnyObject,
                NSForegroundColorAttributeName : UIColor.black.withAlphaComponent(0.2)
            ]
            placeHolderString.draw(at: self.placeholderPoint(), withAttributes: attributes);
            
        }
        
        for path in self.pathArray {
            self.lineColor.setStroke()
            (path as AnyObject).stroke();
        }
        
        
        self.lineColor.setStroke();
        signPath.stroke();
        
    }
    
    
}
