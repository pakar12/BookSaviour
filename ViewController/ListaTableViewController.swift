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
        tableView.rowHeight = 103.5
        tableView.estimatedRowHeight = 103.5
        var  listaCapitulos = [Capitulo]()
        
        let JJ = Autor(nombre: "El desafortunado JJ", foto: UIImage(named: "visto")!, libros: nil)
        
        let capitulo = Capitulo(nombre: "El bolsillo magico de donramon", estado: true, imagenes: [UIImage(named: "nikodemo")!], numero: 1)
        
        listaCapitulos += [capitulo!]
        
        let libro1 = Libro(nombre: "Las desventuras de JJ P", foto: UIImage(named: "nikodemo")!, autor: JJ!, notaMedia: 5.0, definicion: "owo", listaCapitulos: listaCapitulos)
        
        let libro2 = Libro(nombre: "El misterio de pitagoras", foto: UIImage(named: "IconoDefensaGD")!, autor: JJ!, notaMedia: 5.0, definicion: "owo", listaCapitulos: listaCapitulos)
        
        let libro3 = Libro(nombre: "Row Street", foto: UIImage(named: "emptyStar")!, autor: JJ!, notaMedia: 5.0, definicion: "owo", listaCapitulos: listaCapitulos)
        
        libros += [libro1!, libro2!, libro3!]
    }


    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return libros.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Resumen", for: indexPath) as! TableViewCellResumen
        
        cell.resumen.nombre.text = libros[indexPath.row].nombre
        cell.resumen.Autor.text = libros[indexPath.row].autor.nombre
        cell.resumen.foto.image = libros[indexPath.row].foto
        //cell.resumen.Autor.text = libros[indexPath.row].autor
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewDestiny = segue.destination as! LibroViewController
        let selectedRow = tableView.indexPath(for: sender as! TableViewCellResumen)?.row
        viewDestiny.libro = libros[selectedRow!]
    }
}

