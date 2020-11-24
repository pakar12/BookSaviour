//
//  Libro.swift
//  DefensaCD
//
//  Created by Bruno on 18/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class Libro{
    
    var nombre: String
    var foto: UIImage?
    var autor: String
    var definicion: String
    var listaCapitulos: [Capitulo]
    var estado: Int
    
    init?(nombre: String, foto: UIImage?, autor: String, definicion: String, listaCapitulos: [Capitulo]!, estado: Int){
        
        self.nombre = nombre
        self.foto = foto
        self.autor = autor
        self.definicion = definicion
        self.listaCapitulos = listaCapitulos
        self.estado = estado

    }
    
    func seguir(){
        if self.estado == 1{
            self.estado = 3
        }else{
            self.estado = 1
        }
    }
    
    func pendiente(){
        if self.estado == 2{
            self.estado = 3
        }else{
            self.estado = 2
        }
    }
    
}
