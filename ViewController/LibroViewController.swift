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
    
    @IBOutlet weak var descripcion: UILabel!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var leerBoton: UIButton!
    @IBOutlet weak var pendienteBoton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagen.image = libro?.foto
        self.nombreLibro.text = libro?.nombre
        self.autorLibro.text = libro?.autor
        //self.notaMedia.text = libro?.notaMedia + ""
        
    }
    
    func estadoLibro(){

        if libro?.estado == Estado.seguido{
            leerBoton.tintColor = .red
            leer
        } else if(libro?.estado == Estado.pendiente){
            
        } else{
            
        }

    }
    
    @IBAction func atras(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension LibroViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CapituloCell", for: indexPath) as! TableViewCellCapitulo
        
        
        cell.estado.image = libro!.listaCapitulos[indexPath.row].estado!
        cell.numero.text = "\(String(describing: libro!.listaCapitulos[indexPath.row].numero))"
        cell.nombre.text = libro?.listaCapitulos[indexPath.row].nombre
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libro!.listaCapitulos.count
    }
}
