//
//  LoginViewController.swift
//  Jamz
//
//  Created by Adrianna Parlato on 9/26/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    //check the fields and validate that the data is correct. if corrrect, return nil else  return error  message
    
    func validateFields() -> String? {
        
        //check if all fields are filled in
        if
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        //check if password is secure
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPassword) == false {
            //password is not secure
            return "Please make sure  your password is at least 8 characters, contains a special character and a number."
        }
        
        
        return nil
    }
    
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // validate the text fields
        // Validate the user input
        let error  =  validateFields()
        if error != nil {
            // there is an issue with the field, show error message
            showError(error!)
        }
        else {
            
            //create cleaened versions of password and email-- no whiote spaces
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            
            
            //signing in the user
            
            
            
            Auth.auth().signIn(withEmail: email, password: password) {
                (result, error) in
                
                if error != nil {
                    //failed to sign in
                    self.showError("Failed to sign in")
                }
                else {
                    self.transitionToHome()
                }
                
            }
            
            
        }
    }
            
            func showError(_ message:String) {
                errorLabel.text = message
                errorLabel.alpha = 1
            }
            func transitionToHome() {
                let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                view.window?.rootViewController = homeViewController
                view.window?.makeKeyAndVisible()
                
            }
        }
    
