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
    var estado: Bool
    var imagenes: [UIImage]
    var numero: Int
    
    init?(nombre: String, estado: Bool, imagenes: [UIImage]!, numero: Int){
        self.nombre = nombre
        
        self.estado = estado
        
        self.imagenes = imagenes
        self.numero = numero
    }
    
    func verCapitulo(){
        self.estado = true
    }
    
    func tipoVisto() -> UIImage{
        if(estado){
            return UIImage(named: "visto")!
        }
        return UIImage(named: "no-visto")!
    }
    
}
