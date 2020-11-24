//
//  Libro.swift
//  DefensaCD
//
//  Created by Bruno on 23/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData
class LibroNSObject: NSObject {
    
    
    override init() {
        super.init()
    }
    
    init?(libro: Libro){
        super.init()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LibroEntity", in: managedContext)!
        let insercion = NSManagedObject(entity: entity, insertInto: managedContext)
        
        do {
            insercion.setValue(libro.nombre , forKeyPath: "nombre")
            let imageData = libro.foto!.pngData()
            insercion.setValue(imageData, forKey: "foto")
            insercion.setValue(libro.autor, forKeyPath: "autor")
            insercion.setValue(libro.definicion, forKeyPath: "definicion")
            
            
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func consultarLibros(id_usuario: NSManagedObjectID) -> [Libro]?{
        var resultado = [Libro]()
        var consultaInternaCapitulo = [Capitulo]()
        
        var fotoAux: UIImage?
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LibroEntity")
        
        do {
            let libros = try managedContext.fetch(fetchRequest)
            
            let usuario = try managedContext .existingObject(with: id_usuario)
            for libro in libros {
                
                let fetchRequestCapitulos = NSFetchRequest<NSManagedObject>(entityName: "capitulos")
                fetchRequestCapitulos.predicate = NSPredicate(format: "libroProcedente=%@", libro)
                let capitulos = try managedContext.fetch(fetchRequestCapitulos)
                
                //Todos los capitulos marcados x este user
                let fetchRequestEstadoCapitulo = NSFetchRequest<NSManagedObject>(entityName: "capitulos")
                fetchRequestEstadoCapitulo.predicate = NSPredicate(format: "usuarioVisor=%@", usuario)
                let capitulosVistos = try managedContext.fetch(fetchRequestEstadoCapitulo)
                
                for capitulo in capitulos {
                    
                    //hueco para el array de imagenes y para llorar juntos
                    
                    
                    
                    
                    consultaInternaCapitulo.append(Capitulo(nombre: capitulo.value(forKey: "nombre") as! String, estado: capitulosVistos.contains(capitulo), imagenes: [], numero: capitulo.value(forKey: "numero") as! Int)!)
                    
                }
                
                if let imageData = libro.value(forKey: "foto") as? NSData {
                    if let image = UIImage(data: Data(referencing: imageData)) {
                        fotoAux = image
                    }
                }
                
                resultado.append(Libro(nombre: libro.value(forKey: "nombre") as! String, foto: fotoAux, autor:  libro.value(forKey: "autor") as! String,definicion: libro.value(forKey: "definicion") as! String, listaCapitulos: nil, estado: -1)!)
            }
            
            return resultado
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    

}
