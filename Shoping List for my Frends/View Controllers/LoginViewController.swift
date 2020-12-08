//
//  LoginViewController.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 12/5/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var recoveryPasswordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.alpha = 0
    }
    
    func displayWarningLabel(with text: String) {
        warningLabel.text = text
        
        UIView.animate(withDuration: 3,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: { [weak self] in
                self?.warningLabel.alpha = 1
            })
            {[weak self] complete in
                self?.warningLabel.alpha = 0
            }
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text
        else {
            displayWarningLabel(with: "Info is incorrect")
          return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {[weak self] (user, error) in
            guard let self = self else { return }
            if error == nil {
                if user != nil {
                    self.performSegue(withIdentifier: "logInSegue", sender: nil)
                }
            }
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text
        else {
            displayWarningLabel(with: "Info is incorrect")
          return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            guard let self = self else { return }
            if error != nil {
                self.displayWarningLabel(with: "Error ocured")
                return
            }
            if user != nil {
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
                return
            } else {
                self.displayWarningLabel(with: "No such user")
            }
        }
    }
}

