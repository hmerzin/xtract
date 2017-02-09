//
//  ViewController.swift
//  xtract
//
//  Created by Harry Merzin on 2/5/17.
//  Copyright © 2017 Harry Merzin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var albumView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var albumButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { get { return .lightContent } }
    
    let cameraController = UIImagePickerController()
    
    let albumController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.stopAnimating()
        self.view.backgroundColor = Constants.baseColor
        self.cameraController.delegate = self
        self.cameraController.allowsEditing = true
        self.albumController.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.cameraController.sourceType = .camera
        }
        self.albumController.delegate = self
        self.albumController.sourceType = .photoLibrary
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.cameraView.layer.cornerRadius = self.cameraView.bounds.width / 2
        self.albumView.layer.cornerRadius = self.albumView.bounds.width / 2
    }

    @IBAction func chooseFromCamera(_ sender: Any) {
        self.present(cameraController, animated: true)
    }
    
    @IBAction func chooseFromAlbum(_ sender: Any) {
        self.present(albumController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = (info[UIImagePickerControllerEditedImage]! as! UIImage)
        self.activityIndicator.startAnimating()
        Networking.getTextForImage(image: UIImageJPEGRepresentation(image, 0.75)!, completion: { error, wordsArray in
            self.activityIndicator.stopAnimating()
            if(wordsArray == nil) {
                if (error != nil) {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let action = UIAlertAction(title: "Dismiss", style: .default, handler: {(action) -> Void in
                        alert.dismiss(animated: true, completion: {(action) -> Void in })
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
                return
            }
            let text = wordsArray!.map({word in
                return word.replacingOccurrences(of: "\\", with: "")
            })
            let xtracted = Xtracted()
            xtracted.content = text.joined(separator: " ")
            print("content: \(xtracted.content)")
            xtracted.image = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage, 0.75)
            let newController = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
            newController.xtracted = xtracted
            Persistance.saveItem(item: xtracted)
            self.present(newController, animated: true)
        })
        picker.dismiss(animated: true, completion: nil)
    }
    
}

