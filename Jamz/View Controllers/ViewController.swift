//
//  ViewController.swift
//  Jamz
//
//  Created by Adrianna Parlato on 9/26/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var loginButton: UIButton!

    
            
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
       // gradient.type = .radial
        gradient.colors = [ UIColor.systemPurple.cgColor,
                                   UIColor.systemIndigo.withAlphaComponent(255/255).cgColor,
       
                                   UIColor.systemTeal.cgColor,
                                   UIColor.systemGreen.withAlphaComponent(30/255).cgColor,
       
                       ]
       //
                  gradient.locations = [0.34, 0.55, 0.8,1]

//                gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
//        let endY = 0.5 + view.frame.size.width / view.frame.size.height / 2
//        gradient.endPoint = CGPoint(x: 1, y: endY)
        return gradient
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        view.bringSubviewToFront(loginButton)
        view.bringSubviewToFront(signUpButton)
      //  UIApplication.shared.keyWindow?.addSubview(loginButton)
       
        
                //adding background color
             //   let gradient = CAGradientLayer()

//        gradient.colors = [ UIColor.systemPurple.cgColor,
//
//                            UIColor.systemIndigo.withAlphaComponent(255/255).cgColor,
//
//                            UIColor.systemTeal.cgColor,
//                            UIColor.systemGreen.withAlphaComponent(30/255).cgColor,
//
//                ]
//
//            gradient.locations = [0.34, 0.55, 0.8,1]

        //UIStackView(arrangedSubviews: [signUpButton,loginButton])
                   
      
    
        
    }
}
  
