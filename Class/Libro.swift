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
    
    init?(nombre: String, foto: UIImage?, autor: String, notaMedia: Float){
        self.nombre = nombre
        self.foto = foto
        self.notaMedia = notaMedia
        self.autor = autor
    }
    
    
}
