//
//  Autor.swift
//  DefensaCD
//
//  Created by Bruno on 18/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class Autor{
    
    var nombre: String
    var foto: UIImage?
    var libros: [Libro]
    var cantidadPublicaciones: Int
    
    init?(nombre: String, foto: UIImage?, libros: [Libro]){
        self.nombre = nombre
        self.foto = foto
        cantidadPublicaciones = libros.count
        self.libros = libros
    }
    
}
