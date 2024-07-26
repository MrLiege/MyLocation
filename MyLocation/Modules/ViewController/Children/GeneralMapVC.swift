//
//  GeneralMapVC.swift
//  MyLocation
//
//  Created by Artyom Petrichenko on 25.07.2024.
//

import UIKit
import MapKit
import CoreLocation

class GeneralMapVC: UIViewController {
    
    // MARK: - Dependencies
    
    private lazy var locationManager = LocationManager()

    // MARK: - Views
    
    private lazy var mapView: GeneralMapPresentable = {
        let mapView = GeneralMapView()
        mapView.configure()
        return mapView
    }()
    
    private lazy var locationButton: MLButton = {
        let button = MLButton(titleColor: .darkGray, backgroundColor: .lightGray, title: "Показать мою локацию")
        button.addTarget(self, action: #selector(showMyLocation), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(mapView)
        view.addSubview(locationButton)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        locationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
    }
    
    @objc private func showMyLocation() {
        locationManager.startUpdatingLocation()
    }
}


extension GeneralMapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? UserAnnotation else { return nil }
        return UserAnnotationView(annotation: annotation, reuseIdentifier: "userAnnotation")
    }
}


extension GeneralMapVC: LocationManagerDelegate {
    func manager(didUpdate location: CLLocation) {
        mapView.navigate(to: location.coordinate)
    }
    
    func manager(didFailWithError error: Error) {
        let alert = UIAlertController(title: "Ошибка", message: "Проблема с интернетом", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func manager(didFailWithLocationError error: LocationError) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
