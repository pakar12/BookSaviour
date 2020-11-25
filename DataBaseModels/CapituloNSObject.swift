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
        var contador: Int = 0;
        for imagen in capitulo.imagenes {
            let _ = ImagenNSObject.init(imagen: imagen, capitulo: insercion, indice: contador)
            contador = contador + 1
        }
        
        insercion.setValue(libro, forKey: "libroProcedente")
    }
    
    func getCapitulo(nombre: String) -> NSManagedObjectID?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CapituloEntity")
        fetchRequest.predicate = NSPredicate(format: "nombre=%@", nombre)
        //Si ay libro sin capitulos falla
        do{
            return try managedContext.fetch(fetchRequest)[0].objectID
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func updateStateCapitulo(usuario: NSManagedObjectID, capitulo: Capitulo, estado: Int){
        
        let idCapitulo = getCapitulo(nombre: capitulo.nombre)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        if(checkIfExist(usuario: usuario, capitulo: idCapitulo!)){
            do{
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EstadoUsuarioCapitulo")
                fetchRequest.predicate = NSPredicate(format: "estadoCapitulo=%@ and usuarioVisor=%@", try managedContext.existingObject(with: idCapitulo!), try managedContext.existingObject(with: usuario))
                
                var insercion = try managedContext.fetch(fetchRequest)
                
                insercion[0].setValue(estado, forKey: "estado")
                
                try managedContext.save()
                
            }  catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }else{
            
            do{
                let entity = NSEntityDescription.entity(forEntityName: "EstadoUsuarioCapitulo", in: managedContext)!
                let insercion = NSManagedObject(entity: entity, insertInto: managedContext)
                
                insercion.setValue(estado, forKey: "estado")
                insercion.setValue(try managedContext.existingObject(with: idCapitulo!), forKey: "estadoCapitulo")
                insercion.setValue(try managedContext.existingObject(with: usuario), forKey: "usuarioVisor")
                
                try managedContext.save()
                
            }  catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
        }
        
    }
    
    func checkIfExist(usuario: NSManagedObjectID, capitulo: NSManagedObjectID) -> Bool{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return false}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EstadoUsuarioCapitulo")
        
        do {
            fetchRequest.predicate = NSPredicate(format: "estadoCapitulo=%@ and usuarioVisor=%@", try managedContext.existingObject(with: capitulo), try managedContext.existingObject(with: usuario))
            
            if try managedContext.fetch(fetchRequest).count > 0{
                return true
            }else{
                return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return false
    }
}
