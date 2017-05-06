//
//  CropViewController.swift
//  xtract
//
//  Created by Harry Merzin on 2/8/17.
//  Copyright © 2017 Harry Merzin. All rights reserved.
//

import UIKit

class CropViewController: UIViewController {
    
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cropView: UIView!
    
    @IBOutlet var cropViewGestureRecognizer: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.cropViewGestureRecognizer.minimumPressDuration = 0
        self.cropView.layer.borderColor = Constants.baseColor.cgColor
        self.cropView.layer.borderWidth = 5
        self.cropView.bounds = CGRect(origin: self.view.center, size: CGSize(width: 40, height: 40))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var counter = 0
    func adjustConstraints(sender: UILongPressGestureRecognizer) {
        let cropViewBounds = self.cropView.bounds
        let cropLocation = sender.location(in: self.cropView)
        print(sender.location(in: self.imageView).y, cropViewBounds.maxY)
        if(cropLocation.x > cropViewBounds.minX - 15 && cropLocation.x < cropViewBounds.minX + 15) {
            self.leftConstraint.constant = sender.location(in: imageView).x
        }
        
        if(cropLocation.y > cropViewBounds.minY - 15 && cropLocation.y < cropViewBounds.minY + 15) {
            self.topConstraint.constant = sender.location(in: imageView).y
        }
        
        if(cropLocation.x > cropViewBounds.maxX - 15 && cropLocation.x < cropViewBounds.maxX + 15) {
            self.rightConstraint.constant = self.view.bounds.width - sender.location(in: imageView).x
        }
        
        if(cropLocation.y > cropViewBounds.maxY - 15 && cropLocation.y < cropViewBounds.maxY + 15) {
            self.bottomConstraint.constant = self.view.bounds.height - sender.location(in: imageView).y
        }
        
       
    }
    
    @IBAction func cropViewRecognized(_ sender: UILongPressGestureRecognizer) {
        adjustConstraints(sender: sender)
    }
    
}
    
    
    
    
    
    
    
    
    
    
    
    
















    
    //let newX = self.cropView.frame.origin.x + sender.translation(in: self.imageView).x
    //let newY = self.cropView.frame.origin.y - sender.translation(in: self.imageView).y
    //let newWidth = self.cropView.bounds.width - sender.translation(in: self.imageView).x
    //let newHeight = self.cropView.bounds.height + sender.translation(in: self.imageView).y
    //print(newWidth, sender.translation(in: self.imageView).x)
    //if (locationInCropView.x > cropViewBounds.minX - 15 && locationInCropView.x < cropViewBounds.minX + 15) {
    //self.cropView.frame = CGRect(origin: CGPoint(x: newX, y: self.view.center.y), size: CGSize(width: newWidth, height: self.cropView.frame.height))
    //print(true, counter)
    //counter += 1
    
    //if (locationInCropView.y > cropViewBounds.minY - 15 && locationInCropView.y < cropViewBounds.minX + 15) {
    //self.cropView.frame = CGRect(origin: CGPoint(x: self.cropView.center.x, y: newY), size: CGSize(width: newWidth, height: newHeight))
    //}
    
    //print(self.cropView.center.x, newX)
    //print(self.cropView.frame.origin.x, newBounds.minX)
    //sender.setTranslation(CGPoint(x: 0, y: 0), in: self.imageView)
    
    
    
    /*
     
     
     if(locationInCropView.x < cropViewBounds.minX + 15 && locationInCropView.x > cropViewBounds.minX - 15) {
     self.leftConstraint.constant += sender.translation(in: self.view).x
     sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
     
     }
     
     if(locationInCropView.x < cropViewBounds.maxX + 15 && locationInCropView.x > cropViewBounds.maxX - 15) {
     self.rightConstraint.constant -= sender.translation(in: self.view).x
     sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
     }
     */
    //self.leftConstraint.constant += sender.translation(in: self.view).x
    //sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    
    //print(locationInCropView)

