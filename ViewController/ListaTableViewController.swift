//
//  ViewController.swift
//  DefensaCD
//
//  Created by Bruno on 18/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit


class ListaTableViewController: UITableViewController {

    var libros = [Libro]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let libro1 = Libro(nombre: "Las desventuras de JJ P", foto: UIImage(named: "nikodemo")!, autor: "El desafortunado JJ P", notaMedia: 5.0)
        
        let libro2 = Libro(nombre: "El misterio de pitagoras", foto: UIImage(named: "IconoDefensaGD")!, autor: "Pitagoran't", notaMedia: 5.0)
        
        let libro3 = Libro(nombre: "Row Street", foto: UIImage(named: "emptyStar")!, autor: "Rockyoursummer", notaMedia: 3.0)
        
        libros += [libro1!, libro2!, libro3!]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return libros.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Resumen", for: indexPath) as! TableViewCellResumen
        
        cell.resumen.nombre.text = libros[indexPath.row].nombre
        cell.resumen.Autor.text = libros[indexPath.row].autor
        cell.resumen.foto.image = libros[indexPath.row].foto
        //cell.resumen.Autor.text = libros[indexPath.row].autor
        
        return cell
    }
}

