//
//  UserAnnotation.swift
//  MyLocation
//
//  Created by Artyom Petrichenko on 26.07.2024.
//

import Foundation
import MapKit

final class UserAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
