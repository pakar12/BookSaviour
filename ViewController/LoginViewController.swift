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
    
    func comprobarUser() -> Bool{
        return UsuarioNSObject().login(username: username.text!, password: password.text!)
    }
    
   
    @IBAction func loginButtonTapped(_ sender: Any) {
        let _ = shouldPerformSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if (identifier != "loginSegue") {
            return true
        }
        if username.text == nil || username.text?.count == 0 {
            mensajeIncorrecto.isHidden = false
            return false
        }
        if username.text == nil || username.text?.count == 0 {
            mensajeIncorrecto.isHidden = false
            return false
        }
        if (comprobarUser()){
            return true
        }
        mensajeIncorrecto.isHidden = false
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "loginSegue"){
            let viewDestiny = segue.destination as! ListaLibroViewController
           
            viewDestiny.usuario = UsuarioNSObject().getUsuario(username: username.text!)!
        }
    }
    
}

