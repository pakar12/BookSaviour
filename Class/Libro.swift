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
    var notaMedia: Float
    var autor: String
    var definicion: String
    var listaCapitulos: [Capitulo]
    
    init?(nombre: String, foto: UIImage?, autor: String, notaMedia: Float, definicion: String, listaCapitulos: [Capitulo]!){
        
        self.nombre = nombre
        self.foto = foto
        self.autor = autor
        self.notaMedia = notaMedia
        self.definicion = definicion
        self.listaCapitulos = listaCapitulos
    }
    
}
