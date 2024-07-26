//
//  GeneralVC.swift
//  MyLocation
//
//  Created by Artyom Petrichenko on 25.07.2024.
//

import UIKit
import MapKit
import CoreLocation

class GeneralVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
    }
    
    func setupChildControllers() {
        let mapController = GeneralMapVC()
        addChildVC(childVC: mapController, layoutBlock: {
            mapController.view.translatesAutoresizingMaskIntoConstraints = false
            
            mapController.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            mapController.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            mapController.view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            mapController.view.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        }) 
    }

}
