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
    
    override func viewWillAppear(_ animated: Bool) {
        incorrecto.isHidden = true
    }
    
    @IBAction func atras(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func crearBoton(_ sender: Any) {
        if(registrarse()){
            dismiss(animated: true, completion: nil)
        }else{
            incorrecto.isHidden = false
        }
    }
    
    func registrarse() -> Bool{
        if nombre.text == nil || nombre.text!.count == 0 {
            return false
        }
        if password1.text == nil || password1.text!.count == 0 {
            return false
        }
        if password2.text == nil || password2.text!.count == 0 {
            return false
        }
        if password1.text! != password2.text!{
            return false
        }
        return UsuarioNSObject().crearCuenta(username: nombre.text!, password: password1.text!)
    }
}

