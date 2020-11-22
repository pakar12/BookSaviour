//
//  TableViewResumen.swift
//  DefensaCD
//
//  Created by Bruno on 19/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class TableViewCellLibro: UITableViewCell {
    
    @IBOutlet weak var nombre: UILabel!
    
    @IBOutlet weak var autor: UILabel!
    
    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var puntuacion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
