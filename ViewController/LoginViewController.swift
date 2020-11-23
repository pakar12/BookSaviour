//
//  ViewController.swift
//  DefensaCD
//
//  Created by Bruno on 18/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var mensajeIncorrecto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mensajeIncorrecto.isHidden = true
    }
    
    func comprobarUser(){
        
    }

}

