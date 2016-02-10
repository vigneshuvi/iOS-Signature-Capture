//
//  CaptureSignatureViewController.swift
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

import UIKit
import QuartzCore

protocol CaptureSignatureViewDelegate {
    func processCompleted(signImage: UIImage)
}

class CaptureSignatureViewController: UIViewController {
    
    @IBOutlet var captureButton: UIButton!
    var delegate: CaptureSignatureViewDelegate?

    @IBAction func captureSign(sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.processCompleted(self.imageWithView(self.signatureView));
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    @IBOutlet var signatureView: UviSignatureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageWithView(view : UIView) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!);
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        return img;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
