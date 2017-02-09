//
//  CropViewController.swift
//  xtract
//
//  Created by Harry Merzin on 2/8/17.
//  Copyright © 2017 Harry Merzin. All rights reserved.
//

import UIKit

class CropViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: self.imageView)
        if(velocity.x > 0) {
            //self.cropView!.width = sender.location(in: self.imageView)
        }
    }

}
