//
//  ViewController.swift
//  StockUIKit
//
//  Created by Alvaro Torrez on 1/11/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loadingView: UIVisualEffectView!
    
    var test: String {
        get {
            "test"
        }
    }
    
    var test2: String = "test2"
    
    var authService: AuthServiceProtocol? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let authService = DI.shared.resolve(type: AuthServiceProtocol.self) else {
            print("An error was appening on resolve DI for AuthServiceProtocol")
            return
        }
        
        self.authService = authService
        
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
   @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    @IBAction func OnTabOutView(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func performLogin(_ sender: Any) {
        loadingView.isHidden = false
        self.view.endEditing(true)
        authService?.authUser(username: usernameField.text ?? "", password: passwordField.text ?? "", completion: { (status) in
            self.loadingView.isHidden = true
            if status == .SUCCESS {
                self.errorLabel.isHidden = true
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MyStockMainView")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            } else {
                self.errorLabel.isHidden = false
            }
        })

        
    }
}

