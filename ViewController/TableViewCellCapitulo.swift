//
//  TableViewCapitulo.swift
//  DefensaCD
//
//  Created by Bruno on 21/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class TableViewCellCapitulo: UITableViewCell {
    
    @IBOutlet weak var resumen: ResumenLibroView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
