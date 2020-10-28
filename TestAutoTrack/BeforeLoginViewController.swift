//
//  BeforeLoginViewController.swift
//  TestAutoTrack
//
//  Created by name name on 2017/07/31.
//  Copyright © 2017年 name name. All rights reserved.
//

import UIKit

class BeforeLoginViewController: UIViewController {
    @IBAction func tapGoLogin(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "LoginView", bundle: .main)
        let vc:LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let navController = UINavigationController(rootViewController: vc)
        
        self.navigationController!.present(navController, animated: true, completion: nil)
    }
    
}
