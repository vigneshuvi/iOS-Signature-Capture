//
//  CaptureSignatureViewController.swift
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

import UIKit
import QuartzCore

let USER_SIGNATURE_PATH = "user_signature_path"

protocol CaptureSignatureViewDelegate {
    func processCompleted(_ signImage: UIImage)
}

class CaptureSignatureViewController: UIViewController {
    
    @IBOutlet var captureButton: UIButton!
    var delegate: CaptureSignatureViewDelegate?
    var username : NSString?
    var signedDate : NSString?

    @IBAction func captureSign(_ sender: AnyObject) {
        
        //Create the AlertController
        let alertView: UIAlertController = UIAlertController(title: "Saving signature with name", message: "Please enter your name`", preferredStyle: .alert)
        
        //Add a text field
        alertView.addTextField { textField -> Void in
            //TextField configuration
            textField.textColor = UIColor.black
            textField.placeholder = "Name";
        }
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "No, thanks", style: .cancel) { action -> Void in
            //Do some stuff
            alertView.dismiss(animated: true, completion: nil);

        }
        alertView.addAction(cancelAction)
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Yes, please", style: .default) { action -> Void in
            //Do some other stuff
            //Handel your yes please button action here
            let textField:UITextField = (alertView.textFields?[0])!;
            self.username = textField.text as NSString?;
            
            let dateFormatter:DateFormatter = DateFormatter();
            dateFormatter.dateFormat = "dd/MM/yyyy"
            self.signedDate  = dateFormatter.string(from: Date()) as NSString?;
            
            if(self.username != nil && !self.username!.isEqual(to: "") && self.signedDate != nil  && !self.signedDate!.isEqual(to: ""))
            {
                alertView.dismiss(animated: true, completion: nil);
                if let delegate = self.delegate {
                    self.signatureView.captureSignature();
                    let signedImage = self.signatureView.signatureImage(String(format:"By: %@, %@", self.username!, self.signedDate!) as NSString, position: CGPoint(x: self.signatureView.frame.origin.x+10, y: self.signatureView.frame.size.height-25))

                    delegate.processCompleted(signedImage);
                }
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
            }
        }
        alertView.addAction(nextAction)

        //Present the AlertController
        self.present(alertView, animated: true, completion: nil)

    }
    
    
    @IBOutlet var signatureView: UviSignatureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let  data:Data = UserDefaults.standard.object(forKey: USER_SIGNATURE_PATH) as? Data {
            let signPathArray:NSMutableArray = NSKeyedUnarchiver.unarchiveObject(with: data) as! NSMutableArray;
            //self.signatureView.pathArray = signPathArray;
            self.signatureView.pathArray(signPathArray);
            NSLog("Path size : %d",  self.signatureView.pathArray.count);
        }



        self.signatureView.setNeedsDisplay();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
