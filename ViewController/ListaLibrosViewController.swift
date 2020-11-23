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
    
    var libros = [Libro]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 103.5
        tableView.estimatedRowHeight = 103.5
        

        tabBar.delegate = self
       
        tabBar.selectedItem = tabBar.items?[0]
        
        var  listaCapitulos = [Capitulo]()
        
        let capitulo1 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        
        let capitulo2 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        let capitulo3 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        let capitulo4 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        let capitulo5 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        let capitulo6 = Capitulo(nombre: "El bolsillo magico de donramon", estado: false, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        let capitulo7 = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        listaCapitulos += [capitulo1!, capitulo2!, capitulo3!, capitulo4!, capitulo5!, capitulo6!, capitulo7!]
        
        let libro1 = Libro(nombre: "Las desventuras de JJ P", foto: UIImage(named: "nikodemo")!, autor: "El desafortunado JJ", notaMedia: 5.0, definicion: "owo", listaCapitulos: listaCapitulos)
        
        let libro2 = Libro(nombre: "El misterio de pitagoras", foto: UIImage(named: "IconoDefensaGD")!, autor: "El desafortunado JJ", notaMedia: 5.0, definicion: "owo", listaCapitulos: listaCapitulos)
        
        let libro3 = Libro(nombre: "Row Street", foto: UIImage(named: "emptyStar")!, autor: "El desafortunado JJ", notaMedia: 5.0, definicion: "owo", listaCapitulos: listaCapitulos)
        
        libros += [libro1!, libro2!, libro3!]
        
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
        return libros.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Libro", for: indexPath) as! TableViewCellLibro
        
        cell.nombre.text = libros[indexPath.row].nombre
        cell.autor.text = libros[indexPath.row].autor
        cell.foto.image = libros[indexPath.row].foto
        //cell.resumen.Autor.text = libros[indexPath.row].autor
        
        return cell
    }
}

extension ListaLibroViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        if item.tag == 1 {
            print("owo1")
            
        }
        if item.tag == 2 {
            print("owo2")
        }
        if item.tag == 3 {
            print("owo3")
            
        }
        if item.tag == 4 {
            print("owo4")
        }
        print("funciona a medias")
    }
}
