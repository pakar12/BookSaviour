//
//  ListaLibrosViewController.swift
//  DefensaCD
//
//  Created by Bruno on 22/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData
class ListaLibroViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var searchController: UISearchBar!
    var usuario = NSManagedObjectID()
    var libros = [Libro]()
    var filteredBooks = [Libro]()
    
    var estadoBuscado: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchBar
        self.searchController.delegate = self
        
        //Tamaño celda
        tableView.rowHeight = 103.5
        tableView.estimatedRowHeight = 103.5
        
        //TabBar
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?[0]
        
        if(LibroNSObject().bookIsEmpty()){
            fillBooks()
        }
        
        libros = (LibroNSObject().consultarLibros(id_usuario: usuario)!)
        
        busqueda()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        busqueda()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewDestiny = segue.destination as! LibroViewController
        let selectedRow = tableView.indexPath(for: sender as! TableViewCellLibro)?.row
        viewDestiny.libro = filteredBooks[selectedRow!]
        viewDestiny.usuario = self.usuario
    }
    
    func fillBooks(){
        //Datos
        //var  listaCapitulos = [Capitulo]()
        
        let capituloBraco = Capitulo(nombre: "Braco", estado: 1, imagenes: [UIImage(named: "nikodemo")!, UIImage(named: "Braco intro 1")!, UIImage(named: "Braco intro 2")!], numero: 1)
        
        let pitagoras1 = Capitulo(nombre: "planteamiento del problema", estado: 1, imagenes: [UIImage(named: "leer")!], numero: 1)
        let pitagoras2 = Capitulo(nombre: "resolicion temporal", estado: 1, imagenes: [UIImage(named: "pendiente")!], numero: 2)
        let pitagoras3 = Capitulo(nombre: "segundo planteamiento", estado: 1, imagenes: [UIImage(named: "lupa")!], numero: 3)
        
        let RowStreet1 = Capitulo(nombre: "Elmo compra hilo", estado: 1, imagenes: [UIImage(named: "flechaAtras")!], numero: 1)
        let RowStreet2 = Capitulo(nombre: "Elmo enebra la aguja", estado: 1, imagenes: [UIImage(named: "no-visto")!], numero: 2)
        let RowStreet3 = Capitulo(nombre: "Elmo no tiene dedos", estado: 1, imagenes: [UIImage(named: "visto")!], numero: 3)
        
        
        let libro1 = Libro(nombre: "Braco", foto: UIImage(named: "nikodemo")!, autor: "El desafortunado JJ", definicion: "La despedida de nuestro gran pequeño Braco", listaCapitulos: [capituloBraco!], estado: 3)
        
        let libro2 = Libro(nombre: "El misterio de pitagoras", foto: UIImage(named: "IconoDefensaGD")!, autor: "Astor el mecanico", definicion: "Pitagoras se enfrenta a un problema de la edad moderna", listaCapitulos: [pitagoras1!, pitagoras2!, pitagoras3!], estado: 2)
        
        let libro3 = Libro(nombre: "Row Street", foto: UIImage(named: "emptyStar")!, autor: "Elmo el sastre", definicion: "A Elmo le gusta coser", listaCapitulos: [RowStreet1!, RowStreet2!, RowStreet3!], estado: 1)
        
        //libros += [libro1!, libro2!, libro3!]
        
        let _ = LibroNSObject.init(libro: libro1!)
        
        let _ = LibroNSObject.init(libro: libro2!)
        let _ = LibroNSObject.init(libro: libro3!)
        
        
        
    }
}

extension ListaLibroViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            return filteredBooks.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Libro", for: indexPath) as! TableViewCellLibro

        cell.nombre.text = filteredBooks[indexPath.row].nombre
        cell.autor.text = filteredBooks[indexPath.row].autor
        cell.foto.image = filteredBooks[indexPath.row].foto
      
        return cell
    }
}

extension ListaLibroViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        if item.tag == 1 {
            self.estadoBuscado = 1
            busqueda()
        }
        if item.tag == 2 {
            self.estadoBuscado = 2
            busqueda()
        }
        if item.tag == 3 {
            self.estadoBuscado = 3
            busqueda()
        }
        if item.tag == 4 {
            
            dismiss(animated:true, completion: nil)
        }
        print("se deslogea")
    }
}

extension ListaLibroViewController: UISearchBarDelegate{
    
    func busqueda(){
        self.filteredBooks = self.libros.filter{ (libro: Libro) -> Bool in
            if estadoBuscado == libro.estado{
                return true
            }else{
                return false
            }
            
        }
        tableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange search: String){
        if(search.count == 0){
            filteredBooks = libros
            busqueda()
            return
        }
        
        self.filteredBooks = self.libros.filter{ (libro: Libro) -> Bool in
            if(libro.nombre.lowercased().contains(searchBar.text!.lowercased())){
                
                if estadoBuscado == libro.estado{
                    return true
                }else{
                    return false
                }
                
            } else{
                return false
            }
        }
       
        tableView.reloadData()
    }
}
