//
//  ViewController.swift
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

import UIKit



class ViewController: UIViewController, CaptureSignatureViewDelegate {
    
    var secondController: CaptureSignatureViewController?
    @IBOutlet var signatureImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let borderWidth:CGFloat = 2.0
        
        self.signatureImageView.layer.borderColor = UIColor.gray.cgColor;
        self.signatureImageView.layer.borderWidth = borderWidth;
    }
    
    // implementation of the protocol
    func processCompleted(_ signImage: UIImage) {
        signatureImageView.image = signImage;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "view_to_capture" {
            secondController = segue.destination as? CaptureSignatureViewController
            secondController!.delegate = self;
        }
    }


}

