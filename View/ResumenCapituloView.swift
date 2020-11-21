//
//  ResumenLibroView.swift
//  DefensaCD
//
//  Created by Bruno on 19/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class ResumenCapituloView: UIView {
    
    

    @IBOutlet var contentView: UIStackView!
    
    @IBOutlet weak var estado: UIImageView!
    @IBOutlet weak var numeroCapitulo: UILabel!
    @IBOutlet weak var nombreCapitulo: UILabel!
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("ResumenLibro", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
