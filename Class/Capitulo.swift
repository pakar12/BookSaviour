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
    var estado: Int
    var imagenes: [UIImage]
    var numero: Int
    
    init?(nombre: String, estado: Int, imagenes: [UIImage]!, numero: Int){
        self.nombre = nombre
        
        self.estado = estado
        
        self.imagenes = imagenes
        self.numero = numero
    }
    
    func verCapitulo(){
        self.estado = 2
    }
    
    func tipoVisto() -> UIImage{
        if(estado == 1){
            return UIImage(named: "no-visto")!//ojo cerrao
        } else {
            return UIImage(named: "visto")!//ojo abierto
        }
        
    }
    
}
