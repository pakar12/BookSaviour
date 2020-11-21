//
//  ViewController.swift
//  DefensaCD
//
//  Created by Bruno on 18/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class LibroViewController: UIViewController{
    

    var libro: Libro?
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombreLibro: UILabel!
    @IBOutlet weak var autorLibro: UILabel!
    @IBOutlet weak var notaMedia: UILabel!
    
    
    @IBOutlet weak var lista: LibroTableViewController!
    
    @IBOutlet weak var descripcion: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagen.image = libro?.foto
        self.nombreLibro.text = libro?.nombre
        self.autorLibro.text = libro?.autor.nombre
        //self.notaMedia.text = libro?.notaMedia + ""
        
        lista.libro += [libro!]
        
    }
    
    @IBAction func atras(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension LibroViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Content View", for: indexPath) as! TableViewCellCapitulo
        
        cell.capitulo.estado.image = libro?.listaCapitulos[indexPath.row].estado
        cell.capitulo.numeroCapitulo.text = "\(String(describing: libro?.listaCapitulos[indexPath.row].numero))"
        cell.capitulo.nombreCapitulo.text = libro?.listaCapitulos[indexPath.row].nombre
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libro?.listaCapitulos.count ?? 0
    }
}
