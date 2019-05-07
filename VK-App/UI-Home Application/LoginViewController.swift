//
//  LoginViewController.swift
//  UI-Home Application
//
//  Created by Developer on 04/03/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gesture initializing
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Subscribing to the notifications
        //Opening & Closing keyboard
        NotificationCenter.default.addObserver( self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil )
        
        NotificationCenter.default.addObserver( self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil )
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Unsubscribing all
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        if let login = loginTextField.text,
            let password = passwordTextField.text {
            
            //Cleaning text fields
            loginTextField.text = ""
            passwordTextField.text = ""
            
            //Sign In to system check
            if successSignIn(login, password) {
                performSegue(withIdentifier: "signIn", sender: nil)
            } else {
                performAlert(for: "Error", with: "Wrong username or password, try again")
            }
            
        } else {
            performAlert(for: "Error", with: "Username or password not entered")
        }
        
    }
    
    //Alert performing
    func performAlert(for title: String, with message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func successSignIn(_ userLogin: String, _ userPassword: String) -> Bool {
        if userLogin == "admin" { //Password not set
            return true
        } else {
            return false
        }
    }
    
    //Adding extra space for the keyboard
    @objc func keyboardWillShow(notification: Notification){
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardHeight = keyboardFrameValue.cgRectValue.height
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
        
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Deliting extra space for the keyboard
    @objc func keyboardWillHide(notification: Notification){
        let contentInsets = UIEdgeInsets.zero
        
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Hide keyboard on tap
    @objc func hideKeyboard(){
        self.scrollView?.endEditing(true)
    }
    
}
