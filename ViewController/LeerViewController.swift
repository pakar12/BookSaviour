//
//  ViewController.swift
//  DefensaCD
//
//  Created by Bruno on 18/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class LeerViewController: UIViewController , UIScrollViewDelegate{

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var imageArray = [UIImage]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScrollView.frame = view.frame
        imageArray = [UIImage(named: "Braco intro 1")!, UIImage(named: "Braco intro 2")!]
        
        for i in 0..<imageArray.count{
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height)
            
            mainScrollView.contentSize.width = mainScrollView.frame.width * CGFloat(i + 1)
            mainScrollView.addSubview(imageView)
        }
        
        
        
        mainScrollView.minimumZoomScale = 1.0
        mainScrollView.maximumZoomScale = 6.0
        
    }

    @IBAction func atras(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func viewForZooming(in ScrollView: UIScrollView)-> UIView? {
        
        return mainScrollView.subviews[1]
    }
}

