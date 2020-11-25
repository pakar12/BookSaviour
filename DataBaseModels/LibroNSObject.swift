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
            
            
            for capitulo in libro.listaCapitulos {
                let _ = CapituloNSObject.init(capitulo: capitulo, libro: insercion)
            }
            
            
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }
    
    func consultarLibros(id_usuario: NSManagedObjectID) -> [Libro]?{
        var resultado = [Libro]()
        var consultaInternaCapitulo = [Capitulo]()
        var consultaInternaImagenes = [UIImage]()
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
                
                let fetchRequestCapitulos = NSFetchRequest<NSManagedObject>(entityName: "CapituloEntity")
                fetchRequestCapitulos.predicate = NSPredicate(format: "libroProcedente=%@", libro)
                let capitulos = try managedContext.fetch(fetchRequestCapitulos)
                
                
                
                consultaInternaCapitulo.removeAll()
                for capitulo in capitulos {
                    
                    //hueco para el array de imagenes y para llorar juntos
                    let fetchRequestCapituloArrayImagen = NSFetchRequest<NSManagedObject>(entityName: "ImagenesCapituloEntity")
                    fetchRequestCapituloArrayImagen.predicate = NSPredicate(format: "capituloProcedente=%@", capitulo)
                    
                    let imagenesCapitulos = try managedContext.fetch(fetchRequestCapituloArrayImagen)
                    consultaInternaImagenes.removeAll()
                    for imagen in imagenesCapitulos {
                        
                        if let imageData = imagen.value(forKey: "imagen") as? NSData {
                            if let image = UIImage(data: Data(referencing: imageData)) {
                                fotoAux = image
                            }
                        }
                        
                        consultaInternaImagenes.append(fotoAux!)
                    }
                    
                    //Todos los capitulos marcados x este user
                    let fetchRequestEstadoCapitulo = NSFetchRequest<NSManagedObject>(entityName: "EstadoUsuarioCapitulo")
                    fetchRequestEstadoCapitulo.predicate = NSPredicate(format: "usuarioVisor=%@ and estado=%d and estadoCapitulo=%@", usuario, 2, capitulo)
                    
                    let capitulosVistos = try managedContext.fetch(fetchRequestEstadoCapitulo)
                    
                    var capVisto = 1
                    if(capitulosVistos.count > 0){
                        capVisto = 2
                    }
                    
                    consultaInternaCapitulo.append(Capitulo(nombre: capitulo.value(forKey: "nombre") as! String, estado: capVisto, imagenes: consultaInternaImagenes, numero: capitulo.value(forKey: "numero") as! Int)!)
                    
                }
                
                if let imageData = libro.value(forKey: "foto") as? NSData {
                    if let image = UIImage(data: Data(referencing: imageData)) {
                        fotoAux = image
                    }
                }
                
                //Todos los libros marcados x este user
                let fetchRequestEstadoLibro = NSFetchRequest<NSManagedObject>(entityName: "EstadoUsuarioLibro")
                fetchRequestEstadoLibro.predicate = NSPredicate(format: "estadoUsuario=%@ and estadoLibro=%@", usuario, libro)
                
                let estadoLib = try managedContext.fetch(fetchRequestEstadoLibro)
                
                var estadoLibFinal: Int
                if(estadoLib.isEmpty){
                    estadoLibFinal = 3
                }else{
                    estadoLibFinal = estadoLib[0].value(forKey: "estado") as! Int
                }
                
                resultado.append(Libro(nombre: libro.value(forKey: "nombre") as! String, foto: fotoAux, autor:  libro.value(forKey: "autor") as! String,definicion: libro.value(forKey: "definicion") as! String, listaCapitulos: consultaInternaCapitulo, estado: estadoLibFinal)!)
                
            }
            
            return resultado
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func getBook(nombre: String) -> NSManagedObjectID?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LibroEntity")
        fetchRequest.predicate = NSPredicate(format: "nombre=%@", nombre)
        do{
            return try managedContext.fetch(fetchRequest)[0].objectID
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func updateStateBook(usuario: NSManagedObjectID, libro: Libro, estado: Int){
        
        let idBook = getBook(nombre: libro.nombre)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext

      
        if(checkIfExist(usuario: usuario, libro: idBook!)){
            do{
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EstadoUsuarioLibro")
                fetchRequest.predicate = NSPredicate(format: "estadoLibro=%@ and estadoUsuario=%@", try managedContext.existingObject(with: idBook!), try managedContext.existingObject(with: usuario))
                
                 var insercion = try managedContext.fetch(fetchRequest)
                
                insercion[0].setValue(estado, forKey: "estado")
                
                try managedContext.save()
                
            }  catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }else{
            
            do{
                let entity = NSEntityDescription.entity(forEntityName: "EstadoUsuarioLibro", in: managedContext)!
                let insercion = NSManagedObject(entity: entity, insertInto: managedContext)
                
                insercion.setValue(estado, forKey: "estado")
                insercion.setValue(try managedContext.existingObject(with: idBook!), forKey: "estadoLibro")
                insercion.setValue(try managedContext.existingObject(with: usuario), forKey: "estadoUsuario")
                
                try managedContext.save()
                
            }  catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
        }
        
    }
    
    func checkIfExist(usuario: NSManagedObjectID, libro: NSManagedObjectID) -> Bool{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return false}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EstadoUsuarioLibro")
      
        do {
              fetchRequest.predicate = NSPredicate(format: "estadoLibro=%@ and estadoUsuario=%@", try managedContext.existingObject(with: libro), try managedContext.existingObject(with: usuario))
            
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
