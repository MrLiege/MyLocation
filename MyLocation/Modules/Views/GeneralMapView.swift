//
//  GeneralMapView.swift
//  MyLocation
//
//  Created by Artyom Petrichenko on 26.07.2024.
//

import Foundation
import MapKit
import CoreLocation

protocol GeneralMapPresentable: UIView {
    var delegate: MKMapViewDelegate? { get set }
    
    func configure()
    func set(type: MKMapType)
    func navigate(to coordinate: CLLocationCoordinate2D)
}

final class GeneralMapView: MKMapView, GeneralMapPresentable {
    private var userAnnotation: UserAnnotation?
    
    func configure() {
        mapType = .hybrid
        let span = MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 360)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: span)
        setRegion(region, animated: false)
    }
    
    func set(type: MKMapType) {
        mapType = type
    }
    
    func navigate(to coordinate: CLLocationCoordinate2D) {
        
        defer { setRegion(with: coordinate) }
        
        if let annotation = userAnnotation, annotation.coordinate != coordinate {
            UIView.animate(withDuration: 0.3) {
                annotation.coordinate = coordinate
            }
        } else {
            userAnnotation = UserAnnotation(coordinate: coordinate)
            addAnnotation(userAnnotation!)
        }
    }
    
    private func setRegion(with coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        setRegion(region, animated: true)
    }
}
