//
//  SignUpViewController.swift
//  Jamz
//
//  Created by Adrianna Parlato on 9/26/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore


class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
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
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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
    
    
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the user input
        let error  =  validateFields()
        if error != nil {
            // there is an issue with the field, show error message
           showError(error!)
        }
        else {
            
            //create cleaened versions of password and email-- no whiote spaces
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if let err = err {
                    //there is an error creating the user
                    self.showError("Error creating User")
                }
                else {
                    //user was created successfully,  now store the first and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            //show error message (
                            self.showError("User's first and last name could not be saved on the database end")
                        }
                        
                    }
                    // transistion to the home screen
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


