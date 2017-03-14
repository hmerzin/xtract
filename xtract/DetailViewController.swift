//
//  DetailViewController.swift
//  xtract
//
//  Created by Harry Merzin on 2/6/17.
//  Copyright © 2017 Harry Merzin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextField: UITextView!
    
    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    
    @IBOutlet var textFieldSwipe: UISwipeGestureRecognizer!
    
    var xtracted: Xtracted?
    
    var isOnTextField = false
    
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
        self.textFieldSwipe.delegate = self
        /*
        let textViewSwipe = UISwipeGestureRecognizer(target: contentTextField, action: Selector("swipeOnTextView"))
        textViewSwipe.direction = .down
        textViewSwipe.delegate = self
        contentTextField.addGestureRecognizer(textViewSwipe)
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: Notification) {
        //self.contentTextField.constant = self.view.bounds.height - (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect).height
        self.view.frame.origin.y -= (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect).height / 1.4
    }

    func keyboardWillHide(notification: Notification) {
        //self.contentTextFieldBottom.constant = self.view.bounds.height - (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect).height
        print("called")
        print("real")
        self.view.frame.origin.y += (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect).height / 1.4
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == contentTextField) {
            self.titleTextField.isEnabled = false
        } else if(textField == titleTextField) {
            self.contentTextField.isUserInteractionEnabled = false
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField == contentTextField) {
            self.titleTextField.isEnabled = true
        } else if(textField == titleTextField) {
            self.contentTextField.isUserInteractionEnabled = true
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        print("called")
        self.contentTextField.resignFirstResponder()
        self.titleTextField.resignFirstResponder()
    }
    
    @IBAction func swipeOnTextView(_ sender: Any) {
        print("swipe called")
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
}
