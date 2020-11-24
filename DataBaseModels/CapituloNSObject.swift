//
//  CapituloNSObject.swift
//  DefensaCD
//
//  Created by Bruno on 23/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class CapituloNSObject: NSObject {

    override init() {
        super.init()
    }
    
    init?(capitulo: Capitulo, libro: NSManagedObject){
        super.init()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CapituloEntity", in: managedContext)!
        let insercion = NSManagedObject(entity: entity, insertInto: managedContext)
        
        insercion.setValue(capitulo.nombre , forKeyPath: "nombre")
        insercion.setValue(capitulo.numero, forKeyPath: "numero")
            
        for imagen in capitulo.imagenes {
            let _ = ImagenNSObject.init(imagen: imagen, capitulo: insercion)
        }
        
        insercion.setValue(libro, forKey: "libroProcedente")
    }
    
    func getCapitulo(nombre: String) -> NSManagedObjectID?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CapituloEntity")
        fetchRequest.predicate = NSPredicate(format: "nombre=%@", nombre)
        do{
            return try managedContext.fetch(fetchRequest)[0].objectID
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func updateStateChapter(usuario: NSManagedObjectID, capitulo: Capitulo){
        
        var idLibro = getCapitulo(nombre: capitulo.nombre)
        
        
    }
}
