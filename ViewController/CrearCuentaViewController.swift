//
//  ViewController.swift
//  DefensaCD
//
//  Created by Bruno on 18/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class CrearCuentaViewController: UIViewController {

    
    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var password1: UITextField!
    
    @IBOutlet weak var password2: UITextField!
    
    @IBOutlet weak var incorrecto: UILabel!
    
    @IBOutlet weak var boton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        incorrecto.isHidden = true
    }
    
    @IBAction func atras(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func registrarse(){
        
    }
}

