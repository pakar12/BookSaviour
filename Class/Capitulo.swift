//
//  Capitulo.swift
//  DefensaCD
//
//  Created by Bruno on 21/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class Capitulo{
    
    var nombre: String
    var estado: UIImage?
    var imagenes: [UIImage]
    var numero: Int
    
    init?(nombre: String, estado: Bool, imagenes: [UIImage]!, numero: Int){
        self.nombre = nombre
        if(estado == false){
            self.estado = UIImage(named: "no-visto")
        }else{
            self.estado = UIImage(named: "visto")
        }
        
        self.imagenes = imagenes
        self.numero = numero
    }
    
}
