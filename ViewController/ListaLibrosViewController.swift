//
//  ListaLibrosViewController.swift
//  DefensaCD
//
//  Created by Bruno on 22/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class ListaLibroViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var searchController: UISearchBar!
    
    var libros = [Libro]()
    var filteredBooks = [Libro]()
    
    var estadoBuscado: Estado = Estado.seguido
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchBar
            //creamos el SearchBar
        self.searchController.delegate = self
        
        //Tamaño celda de búsqueda
        tableView.rowHeight = 103.5
        tableView.estimatedRowHeight = 103.5
        tableView.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.05098039216, blue: 0.05098039216, alpha: 1)
        //TabBar
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?[0]
        
        //Datos
        var  listaCapitulos = [Capitulo]()
        
        let capitulo1 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        
        let capitulo2 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        let capitulo3 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        let capitulo4 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        let capitulo5 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        let capitulo6 = Capitulo(nombre: "El bolsillo magico de donramon", estado: false, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        let capitulo7 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        listaCapitulos += [capitulo1!, capitulo2!, capitulo3!, capitulo4!, capitulo5!, capitulo6!, capitulo7!]
        
        let libro1 = Libro(nombre: "Las desventuras de JJ P", foto: UIImage(named: "nikodemo")!, autor: "El desafortunado JJ", notaMedia: 5.0, definicion: "owo", listaCapitulos: listaCapitulos, estado: Estado.nada)
        
        let libro2 = Libro(nombre: "El misterio de pitagoras", foto: UIImage(named: "IconoDefensaGD")!, autor: "El desafortunado JJ", notaMedia: 5.0, definicion: "owo", listaCapitulos: listaCapitulos, estado: Estado.pendiente)
        
        let libro3 = Libro(nombre: "Row Street", foto: UIImage(named: "emptyStar")!, autor: "El desafortunado JJ", notaMedia: 5.0, definicion: "owo", listaCapitulos: listaCapitulos, estado: Estado.seguido)
        
        libros += [libro1!, libro2!, libro3!]
        
        

        busqueda()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewDestiny = segue.destination as! LibroViewController
        let selectedRow = tableView.indexPath(for: sender as! TableViewCellLibro)?.row
        viewDestiny.libro = libros[selectedRow!]
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
            self.estadoBuscado = Estado.seguido
            busqueda()
        }
        if item.tag == 2 {
            self.estadoBuscado = Estado.pendiente
            busqueda()
        }
        if item.tag == 3 {
            self.estadoBuscado = Estado.nada
            busqueda()
        }
        if item.tag == 4 {
            print("owo4")
        }
        print("funciona a medias")
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
