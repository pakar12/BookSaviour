//
//  UsuarioNSObject.swift
//  DefensaCD
//
//  Created by Bruno on 24/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData
class UsuarioNSObject: NSObject {
    
    override init() {
        super.init()
    }
    
    init?(usuario: Usuario){
        super.init()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UsuarioEntity", in: managedContext)!
        let insercion = NSManagedObject(entity: entity, insertInto: managedContext)

        do {
            insercion.setValue(usuario.username , forKeyPath: "username")
            insercion.setValue(usuario.password, forKeyPath: "password")
            
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func login(username: String, password: String) -> Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UsuarioEntity")
        fetchRequest.predicate = NSPredicate(format: "username==%@ and password==%@", username, password)
        
        do {
            if(try managedContext.fetch(fetchRequest).count > 0){
                return true
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    func crearCuenta(username: String, password: String) -> Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return false}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UsuarioEntity", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        person.setValue(username, forKeyPath: "username")
        person.setValue(password, forKey: "password")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return true
    }
    
    func getUsuario(username: String) -> NSManagedObjectID?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UsuarioEntity")
        fetchRequest.predicate = NSPredicate(format: "username=%@", username)
        do{
            return try managedContext.fetch(fetchRequest)[0].objectID
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return nil
    }
}
