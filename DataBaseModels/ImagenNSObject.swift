//
//  ImagenNSObject.swift
//  DefensaCD
//
//  Created by Bruno on 23/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData
class ImagenNSObject: NSObject {

    override init() {
        super.init()
    }
    
    init?(imagen: UIImage, capitulo: NSManagedObject, libro: NSManagedObject){
        super.init()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ImagenesCapituloEntity", in: managedContext)!
        let insercion = NSManagedObject(entity: entity, insertInto: managedContext)

        insercion.setValue(imagen.pngData()!, forKey: "imagen")
 
        insercion.setValue(capitulo, forKey: "capituloProcedente")
        
    }
}
