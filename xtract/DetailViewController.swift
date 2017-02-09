//
//  DetailViewController.swift
//  xtract
//
//  Created by Harry Merzin on 2/6/17.
//  Copyright © 2017 Harry Merzin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextField: UITextView!
    
    var xtracted: Xtracted?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageView.layer.shadowColor = UIColor.darkGray.cgColor
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowRadius = 10
        self.imageView.image = UIImage(data: (xtracted?.image)!)
        self.titleTextField.text = xtracted?.title ?? "Title"
        self.contentTextField.text = xtracted?.content
        self.contentTextField.allowsEditingTextAttributes = true
        self.titleTextField.delegate = self
        self.contentTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        print("called")
        self.contentTextField.resignFirstResponder()
        self.titleTextField.resignFirstResponder()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
        Persistance.updateItem(xtracted: self.xtracted!, title: self.titleTextField.text!, content: self.contentTextField.text)
    }
    
    @IBAction func copee(_ sender: Any) {
        let clipboard = UIPasteboard.general
        clipboard.string = self.contentTextField.text
        
    }
    
}
