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
        estadoLibro()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func botonSeguir(_ sender: Any) {
        libro?.seguir()
        estadoLibro()
    }
        
    @IBAction func botonPendiente(_ sender: Any) {
        libro?.pendiente()
        estadoLibro()
    }
    
    func estadoLibro(){

        if libro?.estado == 1{
            leerBoton.tintColor = #colorLiteral(red: 0.8574012518, green: 0.6694219708, blue: 0.1438133121, alpha: 1)
            pendienteBoton.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        } else if(libro?.estado == 2){
            leerBoton.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            pendienteBoton.tintColor = #colorLiteral(red: 0.8574012518, green: 0.6694219708, blue: 0.1438133121, alpha: 1)
        } else{
            leerBoton.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            pendienteBoton.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }

    }
    
    @IBAction func atras(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewDestiny = segue.destination as! LeerViewController
        let selectedRow = tableView.indexPath(for: sender as! TableViewCellCapitulo)?.row
        viewDestiny.imageArray = (libro?.listaCapitulos[selectedRow!].imagenes)!
        
        libro?.listaCapitulos[selectedRow!].verCapitulo()
    }

}

extension LibroViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CapituloCell", for: indexPath) as! TableViewCellCapitulo
        
        
        cell.estado.image = libro!.listaCapitulos[indexPath.row].tipoVisto()
        cell.numero.text = "\(String(describing: libro!.listaCapitulos[indexPath.row].numero))"
        cell.nombre.text = libro?.listaCapitulos[indexPath.row].nombre
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libro!.listaCapitulos.count
    }
}
