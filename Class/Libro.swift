//
//  Libro.swift
//  DefensaCD
//
//  Created by Bruno on 18/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

enum Estado{
    case seguido
    case pendiente
    case nada
}
class Libro{
    
    var nombre: String
    var foto: UIImage?
    var notaMedia: Float
    var autor: String
    var definicion: String
    var listaCapitulos: [Capitulo]
    var estado: Estado
    
    init?(nombre: String, foto: UIImage?, autor: String, notaMedia: Float, definicion: String, listaCapitulos: [Capitulo]!, estado: Estado){
        
        self.nombre = nombre
        self.foto = foto
        self.autor = autor
        self.notaMedia = notaMedia
        self.definicion = definicion
        self.listaCapitulos = listaCapitulos
        self.estado = estado

    }
    
    func seguir(){
        if self.estado == Estado.seguido{
            self.estado = Estado.nada
        }else{
            self.estado = Estado.seguido
        }
    }
    
    func pendiente(){
        if self.estado == Estado.pendiente{
            self.estado = Estado.nada
        }else{
            self.estado = Estado.pendiente
        }
    }
    
}
